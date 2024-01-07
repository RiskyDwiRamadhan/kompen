import 'package:flutter/material.dart';
import 'package:kompen/screens/AmbilTugas/InputAmbilTugas.dart';
import 'package:kompen/Model/modelTugas.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceAmbilTugas.dart';
import 'package:kompen/componen/navigatorDrawer.dart';

class TambahMahasiswaKompenWidget extends StatefulWidget {
  final Tugas tugas;
  final User user;
  const TambahMahasiswaKompenWidget({super.key, required this.tugas, required this.user});

  @override
  State<TambahMahasiswaKompenWidget> createState() =>
      _TambahMahasiswaKompenWidgetState();
}

class _TambahMahasiswaKompenWidgetState
    extends State<TambahMahasiswaKompenWidget> {
  late Tugas tugas;
  String id_tugas = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController nimInput = new TextEditingController();
  TextEditingController kompenInput = new TextEditingController();
  late User user;

  void prosesData() async {
    ServicesAmbilTugas.addTugas(id_tugas, nimInput.text, kompenInput.text).then(
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
                        nimInput.text = "";
                        kompenInput.text = "";
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputAmbilTugasWidget(tugas: tugas,user: user,)),
                            (route) => false);
                      },
                      child: Text('OK'))
                ],
              );
            },
          );
        } else {
          setState(() {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Konfirmasi Data"),
                  content: Text("Data user sudah ada!!"),
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
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
      user = widget.user;
    id_tugas = widget.tugas.idTugas!.toString();
    kompenInput.text = widget.tugas.jumlahKompen!.toString();
    tugas = widget.tugas;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
       drawer: NavigationDrawerWidget(
          user: user,
        ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
        title: Text(
          'Tambah Mahasiswa',
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
                  height: 350,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(222, 222, 231, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 25, 0, 5),
                          child: Text(
                            'NIM',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: TextFormField(
                            controller: nimInput,
                            maxLength: 20,
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Masukkan NIM anda',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 136, 135, 135),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "NIM Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
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
                              hintText: 'Masukkan Jumlah Kompen anda',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 136, 135, 135),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nama Jumlah Kompen Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    prosesData();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5.0,
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  primary: Colors.blue[300],
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    letterSpacing: 1.5,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                            ),
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
    );
  }
}
