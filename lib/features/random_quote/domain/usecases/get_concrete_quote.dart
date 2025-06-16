

import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';

class GetConcreteQuote implements UseCase<Quote,NoParams>{
  @override
  Future<Either<Failure, Quote>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}