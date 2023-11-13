import 'package:flutter/material.dart';
import 'package:kompen/widget/Dosen/TambahDosen.dart';
import 'package:kompen/widget/Dosen/updateDosen.dart';
import 'package:kompen/widget/Model/modelDosen.dart';
import 'package:kompen/widget/Service/serviceDosen.dart';

class dataDosenWidget extends StatefulWidget {
  const dataDosenWidget({Key? key}) : super(key: key);

  @override
  State<dataDosenWidget> createState() => _dataDosenWidgetState();
}

class _dataDosenWidgetState extends State<dataDosenWidget> {
  late List<Dosen> dosen;
  int sortIndex = 0;
  bool isAscending = true;

  _postData(Dosen dosen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDosenWidget(
          nip: dosen.nip,
          namaLengkap: dosen.namaLengkap,
          username: dosen.username,
          password: dosen.password,
          email: dosen.email,
          foto: dosen.foto,
          level: dosen.level,
        ),
      ),
    );
  }

  _deleteData(Dosen dosen) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi Data"),
          content: Text("Apakah Ingin Menghapus Data Ini ??"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                ServicesDosen.deleteDosen(dosen.nip.toString()).then(
                  (result) {
                    if ('success' == result) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Konfirmasi Data"),
                            content: Text("Data user berhasil Dihapus!!"),
                          );
                        },
                      );
                    }
                  },
                );
                Navigator.of(context).pop();
              },
              child: Text('Ya'),
            )
          ],
        );
      },
    );
  }

  sortData() {
    if (sortIndex == 1) {
      dosen.sort((a, b) {
        if (isAscending) {
          return a.namaLengkap
              .toString()
              .toLowerCase()
              .compareTo(b.namaLengkap.toString().toLowerCase());
        } else {
          return b.namaLengkap
              .toString()
              .toLowerCase()
              .compareTo(a.namaLengkap.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 4) {
      dosen.sort((a, b) {
        if (isAscending) {
          return a.level
              .toString()
              .toLowerCase()
              .compareTo(b.username.toString().toLowerCase());
        } else {
          return b.level
              .toString()
              .toLowerCase()
              .compareTo(a.username.toString().toLowerCase());
        }
      });
    }
  }

  void onSort(columnIndex, ascending) {
    sortIndex = columnIndex;
    isAscending = ascending;
    sortData();
    setState(() {});
  }

  _getData() {
    ServicesDosen.getDosens().then((result) {
      setState(() {
        dosen = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    dosen = [];
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TambahDosenWidget()));
        },
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
        elevation: 8,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
        automaticallyImplyLeading: false,
        title: Text(
          'Data Dosen',
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
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: sortIndex,
              sortAscending: isAscending,
              columns: [
                DataColumn(onSort: onSort, label: Text('Foto')),
                DataColumn(onSort: onSort, label: Text('Nama')),
                DataColumn(onSort: onSort, label: Text('Username')),
                DataColumn(onSort: onSort, label: Text('Email')),
                DataColumn(onSort: onSort, label: Text('Level')),
                DataColumn(onSort: onSort, label: Text('Action')),
              ],
              rows: dosen
                  .map((e) => DataRow(cells: [
                        DataCell(Text(e.foto.toString())),
                        DataCell(Text(e.namaLengkap.toString())),
                        DataCell(Text(e.username.toString())),
                        DataCell(Text(e.email.toString())),
                        DataCell(Text(e.level.toString())),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    width: 30,
                                    child: RaisedButton(
                                      child: Icon(
                                        Icons.change_circle,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        _postData(e);
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //       EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              //   child: GestureDetector(
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 0),
                              //       width: 30,
                              //       child: RaisedButton(
                              //         child: Icon(
                              //           Icons.cancel_outlined,
                              //           color: Colors.white,
                              //           size: 30,
                              //         ),
                              //         onPressed: () {
                              //           _deleteData(e);
                              //         },
                              //         padding: EdgeInsets.all(15.0),
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(30.0),
                              //         ),
                              //         color: Colors.red[600],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
