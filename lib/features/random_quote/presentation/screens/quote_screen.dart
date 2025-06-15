

import 'package:clean_architecture_flutter/config/routes/app_routes.dart';
import 'package:clean_architecture_flutter/core/utils/assets_manager.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/core/utils/media_queries_values.dart';
import 'package:clean_architecture_flutter/features/favorute_quote/presentation/screens/favorute_quote_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:InkWell(
            onTap:()=>Constants.showToast(msg: 'Error Happened',color: Colors.red),
            child: Image.asset(ImgAssets.min,width: context.width,)),

      ),
    );
  }
}
