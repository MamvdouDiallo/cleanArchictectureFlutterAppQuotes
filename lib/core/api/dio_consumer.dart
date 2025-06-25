import 'dart:convert';
import 'dart:io';

import 'package:clean_architecture_flutter/core/api/status_code.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../features/injection_container.dart' as di;
import '../error/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_point.dart';


class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = Endpoint.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }


  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
        bool formDataIsEnabled = false,
        Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
      await client.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  //dynamic _handleDioError(DioError error) {}

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException('Erreur de timeout de connexion');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException('Requête incorrecte');
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException('Non autorisé');
          case StatusCode.notFound:
            throw const NotFoundException('Ressource non trouvée');
          case StatusCode.confilct:
            throw const ConflictException('Conflit détecté');
          case StatusCode.internalServerError:
            throw const InternalServerErrorException('Erreur serveur');
          default:
            throw const FetchDataException('Erreur inconnue');
        }

      case DioExceptionType.cancel:
        throw const CancelRequestException('Requête annulée');

      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException('Pas de connexion internet');

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          throw const NoInternetConnectionException(
              'Pas de connexion internet');
        }
        throw const FetchDataException('Erreur inconnue');

      case DioExceptionType.badCertificate:
        throw const BadCertificateException('Certificat invalide');
    }
  }
}
