import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kompen/widget/dashboard/dasboad.dart';
import 'package:kompen/widget/dashboard/dosen.dart';
import 'package:kompen/widget/dashboard/mahasiswa.dart';
import 'package:kompen/widget/login/register.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String? username, password, status, nTabel;

  TextEditingController usernameInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  void prosesLogin() async {
    var dataUser;
    // pilihan DropDown Dosen dan Mahasiswa
    if (nTabel == "Dosen" || nTabel == "Admin") {
      final response = await http.post(
          // Uri.parse("http://192.168.1.200/kompen/login.php"),
          Uri.parse("http://192.168.213.213/kompen/login.php"),
          body: {
            "username": usernameInput.text,
            "password": passwordInput.text
          });

      dataUser = json.decode(response.body);

      if (dataUser.length < 1) {
        setState(() {
          print("data user tidak ada");
        });
      } else {
        setState(
          () {
            username = dataUser[0]["username"];
            password = dataUser[0]["password"];
            status = dataUser[0]["level"];
          },
        );
        if (status == "admin") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DasboadWidget()));
        } else if (status == "dosen") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => DosenWidget()));
        }
      }
      // pilihan Mahasiswa
    } else {
      final response = await http.post(
          // Uri.parse("http://192.168.1.200/kompen/login.php"),
          Uri.parse("http://192.168.213.213/kompen/loginM.php"),
          body: {
            "username": usernameInput.text,
            "password": passwordInput.text
          });

      dataUser = json.decode(response.body);
      if (dataUser.length < 1) {
        setState(() {
          print("data user tidak ada");
        });
      } else {
        setState(
          () {
            username = dataUser[0]["username"];
            password = dataUser[0]["password"];
            status = dataUser[0]["level"];
          },
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MahasiswaWidget()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => RegisterWidget()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Color.fromARGB(101, 0, 0, 0),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up Here',
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
            stops: [0, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(0, 1),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 10),
                child: Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 200,
                    height: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: Image.asset(
                          'assets/images/polinema_logo.png',
                        ).image,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF101213),
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 24),
                        child: Text(
                          'Let\'s get started by filling out the form below.',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                        child: DropdownButton<String?>(
                          value: nTabel,
                          onChanged: (value) {
                            setState(() {
                              nTabel = value;
                            });
                          },
                          items: ["Dosen", "Admin", "Mahasiswa"]
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
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                        child: TextFormField(
                          controller: usernameInput,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
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
                            hintText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                        child: ElevatedButton(
                          onPressed: () {
                            prosesLogin();
                          },
                          child: Text('Sign In'),
                        ),
                      ),
                      _buildSignupBtn(),
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
