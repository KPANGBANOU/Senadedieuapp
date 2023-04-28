// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:senadedieu/interface/wrapper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await Future.delayed(Duration(milliseconds: 3200), (() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "images/logo.png",
          scale: 4.5,
          fit: BoxFit.cover,
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
