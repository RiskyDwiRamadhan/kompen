import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:kompen/Model/modelAlpaku.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceAlpaku.dart';
import 'package:kompen/Service/serviceMahasiswa.dart';
import 'package:kompen/componen/navigatorDrawer.dart';
import 'dart:async';

import 'package:kompen/screens/login/login.dart';

class DashboardMWidget extends StatefulWidget {
  final User user;
  const DashboardMWidget({Key? key, required this.user}) : super(key: key);

  @override
  _DashboardMWidgetState createState() => _DashboardMWidgetState();
}

class _DashboardMWidgetState extends State<DashboardMWidget> {
  Color _circleColor = Colors.blue; // Warna awal
  int _alpa = 0, _kompen = 0, _terkompen = 0;
  late List<Alpaku> alpaku;
  late User user;
  File? _image;
  String id_user = "",
      status = "",
      nama = "",
      noTelp = "",
      password = "",
      username = "",
      email = "",
      foto = "",
      prodi = "",
      statusSP = "SP0";

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
    _perkalianAlpa(widget.user.idUser!);
    ServicesMahasiswa.getAlpaMahasiswa(widget.user.idUser!).then((value) {
      setState(() {
        // alpa = int.parse( value[0].kompen!) - int.parse( value[0].terkompen!);
        prodi = value[0].prodi!;
        _terkompen = int.parse(value[0].terkompen!) ;
        _kompen = _kompen - _terkompen;
        _changeColor();
      });
    });
  }

  void _changeColor() async{
    setState(() {
      if (_alpa >= 56) {
        _circleColor = Colors.black;
        statusSP = "PS";
      } else if (_alpa >= 47) {
        _circleColor = Colors.red;
        statusSP = "SP3";
      } else if (_alpa >= 36) {
        _circleColor = Color.fromARGB(255, 253, 100, 17);
        statusSP = "SP2";
      } else if (_alpa >= 18) {
        _circleColor = Colors.yellow;
        statusSP = "SP1";
      } else {
        _circleColor = Colors.blue; // Warna awal
        statusSP = "SP0";
      }
    });
  }

void _perkalianAlpa(String nim) async{
ServicesAlpaku.getAlpakuWhere(nim).then((value) {
  int index = 0;
  for (var i = value.length-1 ; i >= 0; i--) {
    setState(() {
      int data = value[i].perkalian[index] * int.parse(value[i].jmlAlpa!)  ;
      print("${value[i].perkalian[index]} X ${value[i].jmlAlpa} = ${data}");
      index++;

      _kompen = _kompen + data;
      _alpa = _alpa + int.parse(value[i].jmlAlpa!)  ;
    });
  }
});
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 333,
                  height: 333,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFDFD),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _circleColor,
                      width: 12,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Text(
                          statusSP,
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.black,
                                    fontSize: 60,
                                  ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Divider(
                          thickness: 3,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Text(
                                    'Alpaku',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Text(
                                    _alpa.toString(),
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 90,
                              child: VerticalDivider(
                                thickness: 2,
                                color: Colors.black,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Text(
                                    'Kompen',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Text(
                                  _kompen.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                nama,
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
                prodi,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
