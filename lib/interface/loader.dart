// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.lightBlue.shade900,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "images/logo.png",
            scale: 4.5,
            fit: BoxFit.cover,
            height: 250,
            width: 250,
          ),
        ],
      ),
    );
  }
}
