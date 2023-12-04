import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:kompen/widget/Model/modelUser.dart';
import 'package:kompen/widget/componen/navigatorDrawer.dart';
import 'dart:convert';
import 'package:kompen/widget/login/login.dart';

class DashboardWidget extends StatefulWidget {
  final User user;
  const DashboardWidget({Key? key, required this.user}) : super(key: key);

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final formKey = GlobalKey<FormState>();
  String? nip, nim, kompen, alasan, tugas;

  TextEditingController nimInput = new TextEditingController();
  late User user;
  File? _image;
  String id_user = "", status = "", nama = "", noTelp = "",
         password = "", username = "", email = "", foto = "";

  void _getData() async {
    user = widget.user;
    id_user = user.idUser.toString();
    nama = user.namaLengkap!.toString();
    noTelp = user.noTelp!.toString();
    password = user.password!.toString();
    username= user.username!.toString();
    email = user.email!.toString();
    foto = user.foto!.toString();
    status = user.status!.toString();
  }

  void prosesPencarian() async {
    final response = await http.post(
        // Uri.parse("http://192.168.1.200/kompen/dataM.php"),
        Uri.parse("http://192.168.213.213/kompen/dataM.php"),
        body: {
          "nim": nimInput.text,
        });

    var dataUser = json.decode(response.body);

    if (dataUser == "Error") {
      setState(() {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Konfirmasi Pencarian"),
              content: Text("Data user tidak ada!!"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          },
        );
        print("data user sudah ada!!");
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Konfirmasi Register"),
            content: Text("Data user berhasil ada!! Hallo"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      drawer: NavigationDrawerWidget(
          user: user,
          ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(16, 6, 148, 1),
          title: Text(
            'Dashboard',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Container(
                    width: double.infinity,
                    height: 185,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(222, 222, 231, 1),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Color(0x33000000),
                          offset: Offset(0, 4),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'Cek Kompen Mahasiswa',
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Text(
                          'Masukkan NIM Mahasiswa',
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                          child: TextFormField(
                            controller: nimInput,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(194, 194, 202, 0.671),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(3, 3, 3, 1),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "NIM Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              prosesPencarian();
                            }
                          },
                          child: Text('Cari'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
