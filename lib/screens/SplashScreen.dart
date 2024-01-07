import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:kompen/Service/serviceUser.dart';
import 'package:kompen/screens/dashboard/dashboard.dart';
import 'package:kompen/screens/dashboard/dashboardD.dart';
import 'package:kompen/screens/dashboard/dashboardM.dart';
import 'package:kompen/screens/login/login.dart';
import 'package:kompen/screens/test.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  _SplashScreenWidget createState() => _SplashScreenWidget();
}

class _SplashScreenWidget extends State<SplashScreenWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openSplashScreen();
  }

  String? username, password, status, nTabel;
  openSplashScreen() async {
    //bisa diganti beberapa detik sesuai keinginan
    var durasiSplash = const Duration(seconds: 5);
    final sharedPref = await SharedPreferences.getInstance();

    return Timer(durasiSplash, () async {
      if (sharedPref.containsKey('myData')) {
        final myData = json.decode(sharedPref.getString('myData')!)
            as Map<String, dynamic>;

        nTabel = myData["nTabel"];
        username = myData["username"];
        password = myData["password"];
        print("Auto Login");
        print(nTabel);
        print(username);
        print(password);

        if (nTabel == "Dosen" || nTabel == "Admin") {
          ServicesUser.getDosen(username!, password!).then((result) {
            if (result[0].status! == "Admin") {
              ServicesUser.setdata(
                  result[0].status!, result[0].username!, result[0].password!);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardWidget(
                          user: result[0],
                        )),
                (Route) => false,
              );
            } else if (result[0].status! == "Dosen") {
              ServicesUser.setdata(
                  result[0].status!, result[0].username!, result[0].password!);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardDWidget(user: result[0])),
                (Route) => false,
              );
            }
          });
        } else {
          ServicesUser.getMahasiswa(username!, password!).then((result) {
            ServicesUser.setdata(
                result[0].status!, result[0].username!, result[0].password!);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardMWidget(
                        user: result[0],
                      )),
                (Route) => false,
            );            
          });
        }
      } else {
        //pindah ke Login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginWidget()),
                (Route) => false,
              );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 35, 35),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
                stops: [0, 1],
                begin: AlignmentDirectional(-1, -1),
                end: AlignmentDirectional(1, 1),
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x00FFFFFF), Colors.white],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -1),
                  end: AlignmentDirectional(0, 1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                ],
              ),
            ),
          )
              // ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
              ),
        ],
      ),
    );
  }
}
