
import 'package:clean_architecture_flutter/features/favorute_quote/presentation/screens/favorute_quote_screens.dart';
import 'package:clean_architecture_flutter/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';

class Routes{
  static const String initialRoute="/";
  static const String favouriteQuoteRoute="/favouriteQuote";

}

final routes ={
  Routes.initialRoute:(context)=>const QuoteScreen(),
  Routes.favouriteQuoteRoute:(context)=>const FavoruteQuoteScreen()
};



class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context)=> const QuoteScreen()));
      case Routes.favouriteQuoteRoute:
        return MaterialPageRoute(builder: ((context)=> const FavoruteQuoteScreen()));
      default:
        return undefinedRoute();
    }}



  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
          body: Center(
            child: Text(AppStrings.noRouteFound),
          ),
        )));
  }





}