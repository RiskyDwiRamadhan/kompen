import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceUser.dart';
import 'package:kompen/Service/serviceNetwork.dart';
import 'package:kompen/componen/navigatorDrawer.dart';
import 'package:path/path.dart' as path;
import 'package:kompen/constants.dart';

class ProfileWidget extends StatefulWidget {
  final User user;
  const ProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final formKey = GlobalKey<FormState>();

  TextEditingController noTelpInput = new TextEditingController();
  TextEditingController namaInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController emailInput = new TextEditingController();
  TextEditingController fotoInput = new TextEditingController();

  late User user;
  File? _image;
  String id_user = "", status = "";
  bool isObscure = true;

  _getData() async {
    print("Data user benar!!");
    print(user.username);
    print(user.password);
    print(user.status);
    ServicesUser.getUser(
      user.username!,
      user.password!,
      user.status!,
    ).then(
      (result) {
        if (result.length < 1) {
          print("Data user profile salah!!");
        } else {
          setState(() {
            print("Data user benar!!");
            user = result[0];
            id_user = user.idUser.toString();
            namaInput.text = user.namaLengkap!.toString();
            noTelpInput.text = user.noTelp!.toString();
            passwordInput.text = user.password!.toString();
            usernameInput.text = user.username!.toString();
            emailInput.text = user.email!.toString();
            fotoInput.text = user.foto!.toString();
            status = user.status!.toString();
          });
        }
      },
    );
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
    ServicesUser.updateUser(
            id_user,
            namaInput.text,
            usernameInput.text,
            passwordInput.text,
            emailInput.text,
            noTelpInput.text,
            _image!,
            status.toString())
        .then(
      (result) {
        if ('success' == result) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Konfirmasi Data"),
                content: Text("Data user berhasil diupdate!!"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        _refresh();
                        Navigator.of(context).pop();
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
                  content: Text("Data user gagal diupdate!!"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          _refresh();
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

  Future<void> _refresh() async {
    await _getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
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
          backgroundColor: kPrimaryColor,
          title: Text(
            'Profile',
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
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: double.infinity,
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
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 30, 0, 10),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        serviceNetwork.foto +
                                            user.foto.toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Text(
                                  namaInput.text,
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 5),
                                        child: Text(
                                          'Email',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 8, 0),
                                        child: TextFormField(
                                          controller: emailInput,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Masukkan Email Anda',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 136, 135, 135),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 5),
                                      child: Text(
                                        'Nomor Telepon',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: TextFormField(
                                        controller: noTelpInput,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText:
                                              'Masukkan Nomor Telepon Anda',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 136, 135, 135),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 5),
                                      child: Text(
                                        'Username',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: TextFormField(
                                        controller: usernameInput,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Masukkan Username Anda',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 136, 135, 135),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 5),
                                      child: Text(
                                        'Password',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
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
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 136, 135, 135),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 5),
                                      child: Text(
                                        'Foto',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  color: Color.fromARGB(
                                                      255, 136, 135, 135),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 8),
                                      child: GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 25.0),
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 5.0,
                                                  padding: EdgeInsets.all(10.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  primary: Colors.grey,
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    letterSpacing: 1.5,
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50.0),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      prosesData();
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 5.0,
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                    primary: kPrimaryColor,
                                                  ),
                                                  child: Text(
                                                    'Save',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      letterSpacing: 1.5,
                                                      fontSize: 25.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'OpenSans',
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
                            ],
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
      ),
    );
  }
}
