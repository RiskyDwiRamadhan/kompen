import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:kompen/widget/Model/modelUser.dart';
import 'package:kompen/widget/componen/navigatorDrawer.dart';
import 'dart:async';

import 'package:kompen/widget/login/login.dart';

class DashboardMWidget extends StatefulWidget {
  final User user;
  const DashboardMWidget({Key? key, required this.user}) : super(key: key);

  @override
  _DashboardMWidgetState createState() => _DashboardMWidgetState();
}

class _DashboardMWidgetState extends State<DashboardMWidget> {
  late User user;
  File? _image;
  String id_user = "",
      status = "",
      nama = "",
      noTelp = "",
      password = "",
      username = "",
      email = "",
      foto = "";

  void _getData() async {
    user = widget.user;
    id_user = user.idUser.toString();
    nama = user.namaLengkap!.toString();
    noTelp = user.noTelp!.toString();
    password = user.password!.toString();
    username = user.username!.toString();
    email = user.email!.toString();
    foto = user.foto!.toString();
    status = user.status!.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(
        user: user,
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
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
