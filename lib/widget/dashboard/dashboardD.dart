import 'dart:io';

import 'package:kompen/widget/Alpa/alpaku.dart';
import 'package:flutter/material.dart';
import 'package:kompen/widget/Dosen/dataDosen.dart';
import 'package:kompen/widget/Mahasiswa/dataMahasiswa.dart';
import 'package:kompen/widget/Model/modelUser.dart';
import 'package:kompen/widget/Service/serviceUser.dart';
import 'package:kompen/widget/SplashScreen.dart';
import 'package:kompen/widget/Tugas/dataTugasDosen.dart';
import 'package:kompen/widget/Tugas/inputTugas.dart';
import 'package:kompen/widget/componen/navigatorDrawer.dart';
import 'package:kompen/widget/hukuman/inputHukuman.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kompen/widget/login/login.dart';
import 'package:kompen/widget/test.dart';
import 'package:kompen/widget/users/profile.dart';

class DashboardDWidget extends StatefulWidget {
  final User user;
  const DashboardDWidget({Key? key, required this.user}) : super(key: key);

  @override
  _DashboardDWidgetState createState() => _DashboardDWidgetState();
}

class _DashboardDWidgetState extends State<DashboardDWidget> {
  final formKey = GlobalKey<FormState>();

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

  void prosesRegister() async {
    final response =
        await http.post(Uri.parse("http://192.168.1.200/kompen/dataM.php"),
            // Uri.parse("http://192.168.213.213/kompen/dataM.php"),
            body: {
          "nim": nimInput.text,
        });

    var dataUser = json.decode(response.body);
    var user = dataUser[0].nama_lengkap;

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
            content: Text("Data user berhasil ada!! Hallo $user"),
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
    return Scaffold(
      drawer: NavigationDrawerWidget(
          user: user,
          ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
        title: Text(
          'Dashboard Dosen',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Dasboard Dosen"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => dataDosenWidget(user: user,)));
              },
              child: Text("Dosen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => dataMahasiswaWidget(user: user,)));
              },
              child: Text("Mahasiswa"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AlpakuWidget(user: user,)));
              },
              child: Text("Alpaku"),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Test()));
            //   },
            //   child: Text("Test"),
            // ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProfileWidget()));
              },
              child: Text("Profile"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputHukumanWidget()));
              },
              child: Text("Hukuman"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => dataTugasDosenWidget(user: user,)));
              },
              child: Text("Tugas"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreenWidget()),
                  (Route) => false,
                );
              },
              child: Text("Keluar"),
            ),
          ],
        ),
      ),
    );
  }
}
