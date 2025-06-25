

import 'package:clean_architecture_flutter/core/api/api_consumer.dart';
import 'package:clean_architecture_flutter/core/api/app_interceptors.dart';
import 'package:clean_architecture_flutter/core/api/dio_consumer.dart';
import 'package:clean_architecture_flutter/core/network/network_info.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:clean_architecture_flutter/features/random_quote/data/repositories/quote_repository_imp.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/usecases/get_rendom_quote.dart';
import 'package:clean_architecture_flutter/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


final sl =GetIt.instance;

 Future <void> init() async{
  /// Features
  // Blocs
  sl.registerFactory(()=>RandomQuoteCubit(getRandomQuoteUseCase: sl()));
  // Use cases
  sl.registerLazySingleton(() =>  GetRandomQuote(quoteRepository: sl()));

  //Repository
  sl.registerLazySingleton<QuoteRepository>(() =>QuoteRepositoryImpl(
      networkInfo: sl(),
      randomQuoteLocalDataSource: sl(),
      randomQuoteRemoteDataSource: sl()));

//Data Sources
sl.registerLazySingleton<RandomQuoteLocalDataSource>(() => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));

sl.registerLazySingleton<RandomQuoteRemoteDataSource>(() => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));
// Core

sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

   sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

//External
final sharedPreferences= await SharedPreferences.getInstance();
sl.registerLazySingleton(() => sharedPreferences);
//sl.registerLazySingleton(() => http.Client);
   sl.registerLazySingleton(() => http.Client());
//sl.registerLazySingleton(() => InternetConnectionChecker());
   sl.registerLazySingleton(() => AppIntercepters());
   sl.registerLazySingleton(() => LogInterceptor(
     request: true,
     requestBody: true,
     responseHeader: true,
     responseBody: true,
     error: true
   ));
  sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker.createInstance(),
  );
  sl.registerLazySingleton(() => Dio());
}

