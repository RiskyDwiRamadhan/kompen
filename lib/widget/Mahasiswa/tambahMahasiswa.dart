import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kompen/widget/Mahasiswa/dataMahasiswa.dart';
import 'package:kompen/widget/Model/modelUser.dart';
import 'package:kompen/widget/Service/serviceMahasiswa.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kompen/widget/componen/navigatorDrawer.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class TambahMahasiswaWidget extends StatefulWidget {
  final User user;
  const TambahMahasiswaWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _TambahMahasiswaWidgetState createState() => _TambahMahasiswaWidgetState();
}

class _TambahMahasiswaWidgetState extends State<TambahMahasiswaWidget> {
  String? username, password, prodi;

  final formKey = GlobalKey<FormState>();

  TextEditingController nimInput = new TextEditingController();
  TextEditingController namaInput = new TextEditingController();
  TextEditingController no_telpInput = new TextEditingController();
  TextEditingController th_masukInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController emailInput = new TextEditingController();
  TextEditingController fotoInput = new TextEditingController();
  File? _image;
  late User user;

  void _getUser() async {
    user = widget.user;
  }

  void _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      fotoInput.text = path.basename(_image!.path);
    });
  }

  void prosesData() async {
    ServicesMahasiswa.addMahasiswa(
            nimInput.text,
            namaInput.text,
            prodi.toString(),
            no_telpInput.text,
            usernameInput.text,
            passwordInput.text,
            emailInput.text,
            _image!,
            th_masukInput.text)
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
                        nimInput.text = "";
                        namaInput.text = "";
                        passwordInput.text = "";
                        usernameInput.text = "";
                        fotoInput.text = "";
                        prodi = "";
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dataMahasiswaWidget(user: user,)));
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
    _image;
    _getUser();
  }

  @override
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
                  height: 1065,
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
                            maxLength: 10,
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
                            'Nama Lengkap',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: TextFormField(
                            controller: namaInput,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Nama Lengkap anda',
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
                                return "Nama Lengkap Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Tahun Masuk',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: TextFormField(
                            maxLength: 4,
                            controller: th_masukInput,
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Tahun Masuk anda',
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
                                return "Tahun Masuk Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Program Studi',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: DropdownButton<String?>(
                            value: prodi,
                            onChanged: (value) {
                              setState(() {
                                prodi = value;
                              });
                            },
                            items: [
                              "D4 Sistem Informasi Bisnis",
                              "D4 Teknik Informatika",
                              "D2 Pengembangan Piranti Lunak Situs"
                            ]
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
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: TextFormField(
                            controller: emailInput,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Email anda',
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
                                return "Email Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Nomor Telepon',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: TextFormField(
                            controller: no_telpInput,
                            maxLength: 12,
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Nomor Telepon anda',
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
                                return "Nomor Telepon Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: TextFormField(
                            controller: usernameInput,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Username anda',
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
                                return "Username Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: TextFormField(
                            controller: passwordInput,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Password anda',
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
                                return "Password Masih Kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Foto',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: _getImage,
                                child: Text('Select Image'),
                              ),
                              TextFormField(
                                controller: fotoInput,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
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
                                    return "Foto Masih Kosong";
                                  }
                                  return null;
                                },
                              ),
                            ],
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
