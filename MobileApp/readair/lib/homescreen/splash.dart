import 'dart:async';
import 'package:flutter/material.dart';
import 'package:readair/homescreen/home.dart';  // Adjust the import path to your home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Home Page'), 
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/sparkfunlogo.jpg',  
          width: MediaQuery.of(context).size.width * 0.8,  // Example sizing
        ),
      ),
    );
  }
}
