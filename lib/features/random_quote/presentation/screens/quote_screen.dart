

import 'package:clean_architecture_flutter/config/routes/app_routes.dart';
import 'package:clean_architecture_flutter/core/utils/app_colors.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/core/utils/assets_manager.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/core/utils/media_queries_values.dart';
import 'package:clean_architecture_flutter/features/favorute_quote/presentation/screens/favorute_quote_screens.dart';
import 'package:clean_architecture_flutter/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:clean_architecture_flutter/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/widgets/error_widget.dart' as error_widget;


class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote(){
    BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  }
 @override
 void initState(){
    super.initState();
    _getRandomQuote();

 }
  Widget _buildBodyContent(){
    return BlocBuilder<RandomQuoteCubit,RandomQuoteState>(builder: (context,state){

      if(state is RandomQuoteIsLoading){
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primary,
          ),
        );
      } else if(state is RandomQuoteError){
        return error_widget.ErrorWidget(
          onPress: ()=>_getRandomQuote,
        );
      } else if(state is RandomQuoteLoaded){
        return Column(
          children: [
             QuoteContent(
               quote: state.quote,
             ),
            InkWell(
              onTap:  ()=>_getRandomQuote(),
              child:  Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,color: AppColors.primary
                ),
                child: Icon(Icons.refresh,size: 28,color: Colors.white,),
              ),
            )

          ],
        );
      } else {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primary,
          ),
        );
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    final appBar= AppBar(
        title: const Text(AppStrings.appName),
      );
       return
         //Scaffold(
         //body: error_widget.ErrorWidget(),
       //);
       RefreshIndicator(onRefresh: ()=> _getRandomQuote(),
       child: Scaffold(appBar: appBar,body:_buildBodyContent()));
  }
}
