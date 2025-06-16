

import 'package:clean_architecture_flutter/core/utils/app_colors.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/core/utils/hex_colors.dart';
import 'package:clean_architecture_flutter/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
     onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }


}
