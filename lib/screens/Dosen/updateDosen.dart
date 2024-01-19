import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kompen/constants.dart';
import 'package:kompen/screens/Dosen/dataDosen.dart';
import 'package:kompen/Model/modelDosen.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceDosen.dart';
import 'package:kompen/componen/navigatorDrawer.dart';
import 'package:kompen/widgets/rounded_button.dart';
import 'package:kompen/widgets/widgets.dart';
import 'package:path/path.dart' as path;

class UpdateDosenWidget extends StatefulWidget {
  final User user;
  final Dosen dosen;
  const UpdateDosenWidget({
    Key? key,
    required this.user,
    required this.dosen,
  }) : super(key: key);
  @override
  _UpdateDosenWidgetState createState() => _UpdateDosenWidgetState();
}

class _UpdateDosenWidgetState extends State<UpdateDosenWidget> {
  String? status;
  late List<Dosen> dosen;

  final formKey = GlobalKey<FormState>();

  TextEditingController nipInput = new TextEditingController();
  TextEditingController namaInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController emailInput = new TextEditingController();
  TextEditingController fotoInput = new TextEditingController();
  File? _image;
  late User user;
  bool isObscure = true;

  void getData() async {
    user = widget.user;
    nipInput.text = widget.dosen.nip!.toString();
    namaInput.text = widget.dosen.namaLengkap!.toString();
    passwordInput.text = widget.dosen.password!.toString();
    usernameInput.text = widget.dosen.username!.toString();
    emailInput.text = widget.dosen.email!.toString();
    fotoInput.text = widget.dosen.foto!.toString();
    _image = File(widget.dosen.foto!);
    status = widget.dosen.level!.toString();
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
    ServicesDosen.updateDosen(nipInput.text, namaInput.text, usernameInput.text,
            passwordInput.text, emailInput.text, _image!, status.toString())
        .then(
      (result) {
        if ("success" == result) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Konfirmasi Data"),
                content: Text("Data user berhasil diubah!!"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        nipInput.text = "";
                        namaInput.text = "";
                        passwordInput.text = "";
                        usernameInput.text = "";
                        fotoInput.text = "";
                        status = "";
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dataDosenWidget(
                                      user: user,
                                    )));
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
                  content: Text("Data user gagal diubah!!"),
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
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      drawer: NavigationDrawerWidget(
        user: user,
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Update Dosen',
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(1, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 25, 0, 5),
                          child: Text(
                            'NIP',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                        child: TextFormField(
                          controller: nipInput,
                          maxLength: 20,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Masukkan NIP anda',
                            border: OutlineInputBorder(
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
                              return "NIP Masih Kosong";
                            }
                            return null;
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
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
                            border: OutlineInputBorder(
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
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
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
                            border: OutlineInputBorder(
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
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                        child: TextFormField(
                          controller: passwordInput,
                          autofocus: true,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Password Anda',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              color: kPrimaryColor,
                              icon: Icon(isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
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
                            border: OutlineInputBorder(
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
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Foto',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
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
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                              ),
                            ),
                            TextFormField(
                              controller: fotoInput,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
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
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 5),
                          child: Text(
                            'Level',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 8, 8),
                        child: DropdownButton<String?>(
                          value: status,
                          onChanged: (value) {
                            setState(() {
                              status = value;
                            });
                          },
                          items: [
                            "Admin",
                            "Dosen",
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: RoundedButton(
                          text: 'Update',
                          press: () {
                            if (formKey.currentState!.validate()) {
                              prosesData();
                            }
                          },
                          formKey: formKey,
                        ),
                      ),
                    ],
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
