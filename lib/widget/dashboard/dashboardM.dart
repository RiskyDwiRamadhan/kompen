import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';

import 'package:kompen/widget/login/login.dart';

class DashboardMWidget extends StatefulWidget {
  const DashboardMWidget({Key? key}) : super(key: key);

  @override
  _DashboardMWidgetState createState() => _DashboardMWidgetState();
}

class _DashboardMWidgetState extends State<DashboardMWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
        automaticallyImplyLeading: true,
        title: Align(
          alignment: AlignmentDirectional(0.00, 0.00),
          child: Text(
            'Dashboard',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFDFD),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF1500C7),
                    width: 12,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.00, -1.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: Text(
                          'SP0',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.black,
                            fontSize: 60,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, -1.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          '100',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
            child: Text(
              'Risky Dwi Ramadhan',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Text(
              'Teknik Informatika',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
