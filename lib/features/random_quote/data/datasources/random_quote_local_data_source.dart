

import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/models/quote_models.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RandomQuoteLocalDataSource{
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cacheQuote(QuoteModel quoteModel);
}

class RandomQuoteLocalDataSourceImpl implements RandomQuoteLocalDataSource{
  late final SharedPreferences sharedPreferences;
  @override
  Future<void> cacheQuote(QuoteModel quoteModel) {
return sharedPreferences.setString(AppStrings.cachedRandomQuote, jsonEncode(quoteModel));
  }

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final jsonString= sharedPreferences.getString(AppStrings.cachedRandomQuote);
    if(jsonString != null){
      final cachedRandomQuote = Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cachedRandomQuote;
    }else{
      throw CacheException();
    }
  }
  
}