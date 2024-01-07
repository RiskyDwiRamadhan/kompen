import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:kompen/Model/modelAlpaku.dart';
import 'package:kompen/Model/modelMahasiswa.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceAlpaku.dart';
import 'package:kompen/Service/serviceMahasiswa.dart';
import 'package:kompen/componen/dataSiakad.dart';
import 'package:kompen/componen/perkalian.dart';
import 'package:kompen/componen/navigatorDrawer.dart';

class AlpakuWidget extends StatefulWidget {
  final User user;
  final String id_mahasiswa;
  const AlpakuWidget({Key? key, required this.user,  required this.id_mahasiswa,}) : super(key: key);

  @override
  _AlpakuWidgetState createState() => _AlpakuWidgetState();
}

class _AlpakuWidgetState extends State<AlpakuWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Alpaku> listA = [];
  List<Mahasiswa> listM = [];
  String nim = '';
  int hukuman = 0;
  bool isLoading = false;
  late User user;

  _getAlpaku() async {
    setState(() {
      isLoading = true;
    });
    ServicesAlpaku.getAlpakuWhere(nim).then(
      (result) {
        setState(() {
          listA = result;
          isLoading = false;
        });
      },
    );
  }

  _getMahasiswa() async {
    setState(() {
      isLoading = true;
    });
    ServicesMahasiswa.getAlpaMahasiswa(nim).then(
      (result) {
        setState(() {
          listM = result;
          isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
      user = widget.user;
      nim = widget.id_mahasiswa!;
    _getAlpaku();
    _getMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        drawer: NavigationDrawerWidget(
          user: user,
        ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(16, 6, 148, 1),
          title: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Text(
              'Alpaku',
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      DataSiakad(listA, listM[0]),
                      Perkalian(
                        alpaku: listA,mahasiswa: listM[0],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
