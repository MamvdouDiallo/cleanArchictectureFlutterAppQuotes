

import 'package:clean_architecture_flutter/core/utils/app_colors.dart';
import 'package:clean_architecture_flutter/features/random_quote/domain/entities/quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuoteContent extends StatelessWidget {

  final Quote quote;

  const QuoteContent({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.primary,borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        children: [
          Text(quote.content,textAlign: TextAlign.center,style: TextStyle(
            height: 1.3,
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(quote.author),
          )
        ],
      ),
    );
  }
}
