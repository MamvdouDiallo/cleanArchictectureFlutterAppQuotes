import 'package:bloc/bloc.dart';
import 'package:clean_architecture_flutter/core/error/failures.dart';
import 'package:clean_architecture_flutter/core/usecases/usecase.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/usecases/get_rendom_quote.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase}) : super(RandomQuoteInitial());

  Future<void> getRandomQuote() async{
    Either<Failure,Quote> response= await getRandomQuoteUseCase(NoParams());
    emit(response.fold((failure) => RandomQuoteError(msg: _mapFailureToMsg(failure)), (quote) => RandomQuoteLoaded(quote: quote)));
  }

  String _mapFailureToMsg(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }


}
