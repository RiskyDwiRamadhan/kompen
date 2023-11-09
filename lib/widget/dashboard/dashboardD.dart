import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:kompen/widget/SplashScreen.dart';
import 'package:kompen/widget/Tugas/inputTugas.dart';
import 'package:kompen/widget/hukuman/inputHukuman.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kompen/widget/login/login.dart';
import 'package:kompen/widget/users/profile.dart';

class DashboardDWidget extends StatefulWidget {
  const DashboardDWidget({Key? key}) : super(key: key);

  @override
  _DashboardDWidgetState createState() => _DashboardDWidgetState();
}

class _DashboardDWidgetState extends State<DashboardDWidget> {
  final formKey = GlobalKey<FormState>();
  String? nip, nim, kompen, alasan, tugas;

  TextEditingController nimInput = new TextEditingController();

  void prosesRegister() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.200/kompen/dataM.php"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Dasboard Dosen"),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileWidget()));
              },
              child: Text("Profile"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputHukumanWidget()));
              },
              child: Text("Hukuman"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputTugasWidget()));
              },
              child: Text("Tugas"),
            ),
            RaisedButton(
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
