import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kompen/screens/SplashScreen.dart';
import 'package:kompen/screens/login/login.dart';
import 'package:kompen/screens/test.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenWidget(),
    );
  }
}
