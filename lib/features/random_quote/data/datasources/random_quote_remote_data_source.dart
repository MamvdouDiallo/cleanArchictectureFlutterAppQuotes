

import 'dart:convert';

import 'package:clean_architecture_flutter/core/api/end_point.dart';
import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/models/quote_models.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';

import 'package:http/http.dart' as http;

import '../../../../config/locale/quote_local.dart';
import '../../../../core/api/api_consumer.dart';

abstract class RandomQuoteRemoteDataSource{
  Future<QuoteModel> getRandomeQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource{

 // final QuoteLocalDataSource dataSource;

  ApiConsumer apiConsumer;
  //RandomQuoteRemoteDataSourceImpl({required this.client});
 // http.Client client;
  RandomQuoteRemoteDataSourceImpl({required this.apiConsumer});

  /*
  @override
  Future<QuoteModel> getRandomeQuote() async {
    print("hello");
    final randomQuoteUrl= Uri.parse(Endpoint.randomQuote);
    final response = await client.get(randomQuoteUrl,headers: {AppStrings.contentType : AppStrings.applicationJson});
    if(response.statusCode==200){
      print(response);
      return QuoteModel.fromJson(jsonDecode(response.body));
    } else{
      throw ServerException();
    }
  }

   */

  @override
  Future<QuoteModel> getRandomeQuote() async {
    print("hello");
    final randomQuoteUrl= Uri.parse(Endpoint.randomQuote);
    final response = await apiConsumer.get(Endpoint.randomQuote);
    //print(response.body);
    return QuoteModel.fromJson(jsonDecode(response.body));
  }


}