import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:kompen/widget/Service/serviceMahasiswa.dart';
import 'package:kompen/widget/Service/serviceTugas.dart';
import 'package:kompen/widget/Tugas/dataTugasDosen.dart';
import 'dart:convert';

import 'package:kompen/widget/login/login.dart';

class TambahTugasWidget extends StatefulWidget {
  const TambahTugasWidget({Key? key}) : super(key: key);

  @override
  _TambahTugasWidgetState createState() => _TambahTugasWidgetState();
}

class _TambahTugasWidgetState extends State<TambahTugasWidget> {
  final formKey = GlobalKey<FormState>();
  String? nip = '69439',kategori;

  TextEditingController judulInput = new TextEditingController();
  TextEditingController kuotaInput = new TextEditingController();
  TextEditingController kompenInput = new TextEditingController();
  TextEditingController deskripsiInput = new TextEditingController();

  void prosesData() async {
   ServicesTugas.addTugas(nip!, judulInput.text, kategori.toString(), kuotaInput.text, kompenInput.text,
            deskripsiInput.text)
        .then(
      (result) {
        if ('success' == result) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Konfirmasi Data"),
                content: Text("Data user berhasil ditambahkan!!"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        judulInput.text = "";
                        kategori = "";
                        kuotaInput.text = "";
                        kompenInput.text = "";
                        deskripsiInput.text = "";
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dataTugasDosenWidget()));
                      },
                      child: Text('OK'))
                ],
              );
            },
          );
        } else if ('ID Dosen Salah' == result) {
          setState(() {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Konfirmasi Data"),
                  content: Text(result),
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
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(16, 6, 148, 1),
          automaticallyImplyLeading: false,
          title: Text(
            'Input Tugas',
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 50, 20, 20),
                  child: Container(
                    width: double.infinity,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(222, 222, 231, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 15, 0, 5),
                            child: Text(
                              'Kategori',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: DropdownButton<String?>(
                            value: kategori,
                            onChanged: (value) {
                              setState(() {
                                kategori = value;
                              });
                            },
                            items: ["Penugasan", "Pembelian"]
                                .map<DropdownMenuItem<String?>>(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.toString()),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                            child: Text(
                              'Judul Tugas',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                            child: TextFormField(
                              controller: judulInput,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Judul Masih Kosong";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                            child: Text(
                              'Kuota',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                            child: TextFormField(
                              controller: kuotaInput,
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
                                  return "Kuota Masih Kosong";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                            child: Text(
                              'Jumlah Kompen',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                            child: TextFormField(
                              controller: kompenInput,
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
                                  return "Jumlah Kompen Masih Kosong";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                            child: Text(
                              'Deskripsi',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                            child: TextFormField(
                              controller: deskripsiInput,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Deskripsi Masih Kosong";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  prosesData();
                                }
                              },
                              child: Text('Save'),
                            ),
                          ),
                        ],
                      ),
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
