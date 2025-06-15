import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorute_quote_state.dart';

class FavoruteQuoteCubit extends Cubit<FavoruteQuoteState> {
  FavoruteQuoteCubit() : super(FavoruteQuoteInitial());
}
