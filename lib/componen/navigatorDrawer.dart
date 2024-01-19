import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceUser.dart';
import 'package:kompen/constants.dart';
import 'package:kompen/screens/Alpa/alpaku.dart';
import 'package:kompen/screens/Dosen/dataDosen.dart';
import 'package:kompen/screens/Mahasiswa/dataMahasiswa.dart';
import 'package:kompen/screens/SplashScreen.dart';
import 'package:kompen/screens/Tugas/allHistory.dart';
import 'package:kompen/screens/Tugas/dataTugasDosen.dart';
import 'package:kompen/screens/Tugas/dataTugasReady.dart';
import 'package:kompen/screens/Tugas/historyTugasDosen.dart';
import 'package:kompen/screens/Tugas/historyTugasMahasiswa.dart';
import 'package:kompen/screens/dashboard/dashboard.dart';
import 'package:kompen/screens/dashboard/dashboardD.dart';
import 'package:kompen/screens/dashboard/dashboardM.dart';
import 'package:kompen/screens/users/profile.dart';
import 'package:kompen/Service/serviceNetwork.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final User user;

  NavigationDrawerWidget({required this.user});

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  double userHeight = 200.0; // Tinggi container awalgi container awal
  double tugasHeight = 400.0; // Tinggi container awalgi container awal

  bool showUsersMenu = true;
  bool showMahasiswaMenu = true;
  bool showUserMenu = true;

  bool showAlpakuMenu = true;
  bool showTugasMenu = true;
  bool showDaftarTugasMenu = true;
  bool showTugasReadyMenu = true;
  bool showHistoryTugasMenu = true;
  bool showSemuaHistoryTugasMenu = true;
  bool showHistoryTugasMahasiswaMenu = true;

  late User user;
  File? _image;
  String id_user = "",
      status = "",
      nama = "",
      noTelp = "",
      password = "",
      username = "",
      email = "",
      foto = "";

  Future _getData() async {
    ServicesUser.getUser(
      user.username!,
      user.password!,
      user.status!,
    ).then(
      (result) {
        if (result.length < 1) {
          print("Data Drawer salah!!");
        } else {
          setState(() {
            print("Data user benar!!");
            user = result[0];
            id_user = user.idUser.toString();
            nama = user.namaLengkap!.toString();
            noTelp = user.noTelp!.toString();
            password = user.password!.toString();
            username = user.username!.toString();
            email = user.email!.toString();
            foto = user.foto!.toString();
            status = user.status!.toString();
            _whereStatus();
          });
        }
      },
    );
  }

  Future _whereStatus() async {
    if (status == "Admin") {
      showAlpakuMenu = false;
      showHistoryTugasMahasiswaMenu = false;
    } else if (status == "Dosen") {
      showAlpakuMenu = false;
      showUsersMenu = false;
      showHistoryTugasMahasiswaMenu = false;
    } else if (status == "Mahasiswa") {
      // Mahasiswa
      showUsersMenu = false;
      showDaftarTugasMenu = false;
      showHistoryTugasMenu = false;
      showSemuaHistoryTugasMenu = false;
    }
  }

  _animasiMenu(double awal, double tutup, String height, String show) async {
    if (userHeight == awal) {
      setState(() {
        userHeight = tutup;
        showUserMenu = true;
      });
    } else {
      setState(() {
        userHeight = awal;
        showUserMenu = false;
      });
    }
  }

  Future<void> _refreshData() async {
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
    return Drawer(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        child: Material(
          color: kPrimaryColor,
          child: ListView(
            children: <Widget>[
              buildProfile(urlImage: foto, name: nama, onClicked: () {}),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    // const SizedBox(height: 12),
                    Divider(color: Colors.white70),
                    buildMenuItem(
                      text: 'Dashboard',
                      icon: Icons.dashboard,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    Visibility(
                      visible: showAlpakuMenu,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: buildMenuItem(
                            text: 'Alpaku',
                            icon: Icons.workspaces_outline,
                            onClicked: () => selectedItem(context, 5)),
                      ),
                    ),

                    Visibility(
                      visible: showUsersMenu,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: userHeight,
                        child: Column(
                          children: [
                            Divider(color: Colors.white70),
                            buildMenuItem(
                                text: 'Users',
                                icon: Icons.people,
                                onClicked: () {
                                  if (userHeight == 90) {
                                    setState(() {
                                      userHeight = 200;
                                      showUserMenu = true;
                                    });
                                  } else {
                                    setState(() {
                                      userHeight = 90;
                                      showUserMenu = false;
                                    });
                                  }
                                }),
                            Divider(color: Colors.white70),
                            Visibility(
                              visible: showUserMenu,
                              child: buildMenuItem(
                                text: 'Admin/Dosen/Teknisi',
                                icon: Icons.workspaces_outline,
                                onClicked: () => selectedItem(context, 11),
                              ),
                            ),
                            Visibility(
                              visible: showUserMenu,
                              child: buildMenuItem(
                                text: 'Mahasiswa',
                                icon: Icons.workspaces_outline,
                                onClicked: () => selectedItem(context, 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      // height: tugasHeight,
                      child: Column(
                        children: [
                          Divider(color: Colors.white70),
                          buildMenuItem(
                              text: 'Tugas',
                              icon: Icons.library_books_outlined,
                              onClicked: () {
                                // if (userHeight == 90) {
                                //   setState(() {
                                //     userHeight = 400;
                                //     showDaftarTugasMenu = true;
                                //     showTugasReadyMenu = true;
                                //     showHistoryTugasMenu = true;
                                //     showSemuaHistoryTugasMenu = true;
                                //   });
                                // } else {
                                //   setState(() {
                                //     userHeight = 90;
                                //     showDaftarTugasMenu = false;
                                //     showTugasReadyMenu = false;
                                //     showHistoryTugasMenu = false;
                                //     showSemuaHistoryTugasMenu = false;
                                //   });
                                // }
                              }),
                          Divider(color: Colors.white70),
                          Visibility(
                            visible: showDaftarTugasMenu,
                            child: buildMenuItem(
                              text: 'Daftar Tugas',
                              icon: Icons.radio_button_checked_rounded,
                              onClicked: () => selectedItem(context, 21),
                            ),
                          ),
                          Visibility(
                            visible: showTugasReadyMenu,
                            child: buildMenuItem(
                              text: 'Daftar Tugas Ready',
                              icon: Icons.radio_button_checked_rounded,
                              onClicked: () => selectedItem(context, 22),
                            ),
                          ),
                          Visibility(
                            visible: showHistoryTugasMenu,
                            child: buildMenuItem(
                              text: 'Historyku',
                              icon: Icons.update,
                              onClicked: () => selectedItem(context, 23),
                            ),
                          ),
                          Visibility(
                            visible: showSemuaHistoryTugasMenu,
                            child: buildMenuItem(
                              text: 'Semua History',
                              icon: Icons.update,
                              onClicked: () => selectedItem(context, 24),
                            ),
                          ),
                          Visibility(
                            visible: showHistoryTugasMahasiswaMenu,
                            child: buildMenuItem(
                              text: 'History Tugasku',
                              icon: Icons.update,
                              onClicked: () => selectedItem(context, 25),
                            ),
                          ),
                          Divider(color: Colors.white70),
                        ],
                      ),
                    ),
                    buildMenuItem(
                      text: 'LogOut',
                      icon: Icons.logout,
                      onClicked: () => selectedItem(context, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfile({
    required String urlImage,
    required String name,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(serviceNetwork.foto + urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {
                      selectedItem(context, 4);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: Color.fromRGBO(27, 48, 158, 1),
                    ),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        if (status == "Admin") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardWidget(
                        user: user,
                      )),
              (route) => false);
        } else if (status == "Dosen") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardDWidget(
                        user: user,
                      )),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardMWidget(
                        user: user,
                      )),
              (route) => false);
        }
        break;
      case 4:
        // Profile
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 5:
        // Alpaku
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => AlpakuWidget(
                      user: user,
                      id_mahasiswa: user.idUser!,
                    )),
            (route) => false);
        break;
      case 1:
        // if (userHeight == 90.0) {
        //   setState(() {
        //     userHeight = 200.0;
        //     showUserMenu = true;
        //     showMahasiswaMenu = true;
        //   });
        // } else {
        //   setState(() {
        //     userHeight = 90.0;
        //     showUserMenu = false;
        //     showMahasiswaMenu = false;
        //   });
        // }
        break;
      case 11:
        // Data Dosen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => dataDosenWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 12:
        // Data Mahasiswa
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => dataMahasiswaWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 2:
        if (tugasHeight == 90.0) {
        } else {}
        break;
      case 21:
        // Tugas Dosen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => dataTugasDosenWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 22:
        // Tugas Ready
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => dataTugasReadyWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 23:
        // Historyku
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => historyTugasDosenWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 24:
        // Semua History
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => allHistoryTugasDosenWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 25:
        // Semua History
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => historyTugasMahasiswaWidget(
                      user: user,
                    )),
            (route) => false);
        break;
      case 3:
        // LogOut
        final sharedPref = await SharedPreferences.getInstance();
        sharedPref.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SplashScreenWidget()),
            (route) => false);
        break;
    }
  }
}
