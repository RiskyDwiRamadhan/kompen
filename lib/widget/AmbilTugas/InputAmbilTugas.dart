import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kompen/widget/AmbilTugas/tambahMahasiswaKompen.dart';
import 'package:kompen/widget/Model/modelTugas.dart';
import 'package:kompen/widget/componen/dataAmbilTugasWidget.dart';

class InputAmbilTugasWidget extends StatefulWidget {
  final Tugas tugas;
  const InputAmbilTugasWidget({Key? key, required this.tugas}) : super(key: key);

  @override
  _InputAmbilTugasWidgetState createState() => _InputAmbilTugasWidgetState();
}

class _InputAmbilTugasWidgetState extends State<InputAmbilTugasWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Tugas tugas;
  late String? judul_tugas, tipe, kuota, kompen, Tanggal, deskripsi, id_tugas;

  void _getDataTugas() async {
    tugas = widget.tugas;
    id_tugas = widget.tugas.idTugas;
    judul_tugas = widget.tugas.judulTugas;
    tipe = widget.tugas.kategori;
    kuota = widget.tugas.kuota;
    kompen = widget.tugas.jumlahKompen;
    Tanggal = widget.tugas.tgl;
    deskripsi = widget.tugas.deskripsi;
  }

  @override
  void initState() {
    super.initState();
     _getDataTugas();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
          automaticallyImplyLeading: false,
          title: Text(
            'Ambil Tugas',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TambahMahasiswaKompenWidget(tugas: tugas,)));
        },
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
        elevation: 8,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Container(
                            width: double.infinity,
                            height: 73,
                            decoration: BoxDecoration(
                              color: Color(0xFF1E30A5),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-1.00, 0.00),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Data Tugas',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Judul Tugas',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(92, 0, 0, 0),
                                child: Text(
                                  judul_tugas!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Tipe Tugas',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20,
                                    ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      105, 0, 0, 0),
                                  child: Text(
                                    tipe!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 20,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Kuota ',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    145, 0, 0, 0),
                                child: Text(
                                  kuota!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Kompen ',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    42, 0, 0, 0),
                                child: Text(
                                  kompen!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Tanggal',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    135, 0, 0, 0),
                                // child: Text(
                                //   Tanggal!,
                                //   textAlign: TextAlign.start,
                                //   style: TextStyle(
                                //         fontFamily: 'Readex Pro',
                                //         fontSize: 20,
                                //       ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Deskripsi',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 20,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    120, 0, 0, 0),
                                child: Text(
                                  deskripsi!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 900,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: dataAmbilTugasWidget(id_tugas: id_tugas),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
