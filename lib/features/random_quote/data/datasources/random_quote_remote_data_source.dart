

import 'dart:convert';

import 'package:clean_architecture_flutter/core/api/end_point.dart';
import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/models/quote_models.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';

import 'package:http/http.dart' as http;

abstract class RandomQuoteRemoteDataSource{
  Future<QuoteModel> getRandomeQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource{
  RandomQuoteRemoteDataSourceImpl({required this.client});
  http.Client client;
  @override
  Future<QuoteModel> getRandomeQuote() async {
    final randomQuoteUrl= Uri.parse(Endpoint.randomQuote);
    final response = await client.get(randomQuoteUrl,headers: {AppStrings.contentType : AppStrings.applicationJson});
    if(response.statusCode==200){
      return QuoteModel.fromJson(jsonDecode(response.body));
    } else{
      throw ServerException();
    }
  }
}