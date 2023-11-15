import 'package:flutter/material.dart';
import 'package:kompen/widget/Dosen/dataDosen.dart';
import 'package:kompen/widget/SplashScreen.dart';
import 'package:kompen/widget/test.dart';

void main() async{
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
      home: dataDosentestWidget(),
    );
  }
}