

import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRandomQuote  implements UseCase<Quote,NoParams>{
  final QuoteRepository quoteRepository;
  GetRandomQuote({required this.quoteRepository});
  @override
  Future<Either<Failure, Quote>> call(NoParams params) =>
     quoteRepository.getRandomeQuote();

}
/*

class LoginParams extends Equatable{
  final String userName;
  final String password;

  const LoginParams({required this.userName,required this.password});
  @override
  List<Object?> get props => [userName,password];


 */


















