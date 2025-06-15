


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoruteQuoteScreen extends StatefulWidget {
  const FavoruteQuoteScreen({super.key});

  @override
  State<FavoruteQuoteScreen> createState() => _FavoruteQuoteScreenState();
}

class _FavoruteQuoteScreenState extends State<FavoruteQuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Favorute",style: TextStyle(fontSize: 25,color: Colors.black),),
      ),
    );
  }
}
