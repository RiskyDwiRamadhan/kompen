import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';

class DasboadWidget extends StatefulWidget {
  const DasboadWidget({Key? key}) : super(key: key);

  @override
  _DasboadWidgetState createState() => _DasboadWidgetState();
}

class _DasboadWidgetState extends State<DasboadWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // openDasboad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Text("Dasboard"),
      ),
    );
  }
}
