import 'package:flutter/material.dart';
import 'package:kompen/widget/Alpa/alpaku.dart';
import 'package:kompen/widget/Dosen/dataDosen.dart';
import 'package:kompen/widget/Model/modelAlpaku.dart';
import 'package:kompen/widget/Service/authProvider.dart';
import 'package:kompen/widget/SplashScreen.dart';
import 'package:kompen/widget/Tugas/dataTugasDosen.dart';
import 'package:kompen/widget/Tugas/dataTugasReady.dart';
import 'package:kompen/widget/dashboard/dashboardD.dart';
import 'package:kompen/widget/login/login.dart';
import 'package:kompen/widget/test.dart';
import 'package:provider/provider.dart';


void main() async{
  runApp(
      const MyApp()
  );
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
      home: LoginWidget(),
    );
  }
}