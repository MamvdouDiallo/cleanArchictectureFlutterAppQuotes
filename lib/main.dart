import 'package:clean_architecture_flutter/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'config/locale/database_helper.dart';
import 'features/injection_container.dart' as di;

/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const QuoteApp());
}


 */


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await DatabaseHelper.instance.database;
  Bloc.observer = AppBlocObserver();
  runApp(
    const QuoteApp(),
  );
}
