


import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/models/quote_models.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:dartz/dartz.dart';

class QuoteRepositoryImpl implements QuoteRepository{
   final NetworkInfo networkInfo;
   final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
   final RandomQuoteLocalDataSource randomQuoteLocalDataSource;
  QuoteRepositoryImpl( {
    required this.networkInfo,
    required this.randomQuoteLocalDataSource,
    required this.randomQuoteRemoteDataSource
});

  @override
  Future<Either<Failure, Quote>> getRandomeQuote() async {
    if(await networkInfo.isConnected){
      try {
        final remoteRandomQuote = await randomQuoteRemoteDataSource.getRandomeQuote();
        return Right(remoteRandomQuote);
      }on ServerException{
        return Left(ServerFailure());
      }
    } else{
      try{
        final cachedRamdomQuote= await randomQuoteLocalDataSource.getLastRandomQuote();
        return Right(cachedRamdomQuote);
      } on CacheException{
        return Left(CacheFailure());
      }
    }

  }

}