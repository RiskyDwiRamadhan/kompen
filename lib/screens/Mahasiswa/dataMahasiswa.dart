import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kompen/constants.dart';
import 'package:kompen/screens/Mahasiswa/tambahMahasiswa.dart';
import 'package:kompen/screens/Mahasiswa/updateMahasiswa.dart';
import 'package:kompen/Model/modelMahasiswa.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceMahasiswa.dart';
import 'package:kompen/Service/serviceNetwork.dart';
import 'package:kompen/componen/navigatorDrawer.dart';

class dataMahasiswaWidget extends StatefulWidget {
  final User user;
  const dataMahasiswaWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<dataMahasiswaWidget> createState() => _dataMahasiswaWidgetState();
}

class _dataMahasiswaWidgetState extends State<dataMahasiswaWidget> {
  late List<Mahasiswa> mahasiswa;
  int sortIndex = 0;
  bool isAscending = true;
  bool isLoading = false; // Track the loading state
  String searchText = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cariInput = new TextEditingController();

  late User user;
  File? _image;
  String id_user = "", status = "";

  void _getUser() async {
    user = widget.user;
    id_user = user.idUser.toString();
    status = user.status!.toString();
  }

  _postData(Mahasiswa mahasiswa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateMahasiswaWidget(
          user: user,
          mahasiswa: mahasiswa,
        ),
      ),
    );
  }

  _deleteData(Mahasiswa mahasiswa) {
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
                ServicesMahasiswa.deleteMahasiswa(mahasiswa.nim.toString())
                    .then(
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
                setState(() {
                  _refreshData();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Ya'),
            )
          ],
        );
      },
    );
  }

  sortData() {
    if (sortIndex == 2) {
      mahasiswa.sort((a, b) {
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
    } else if (sortIndex == 3) {
      mahasiswa.sort((a, b) {
        if (isAscending) {
          return a.thMasuk
              .toString()
              .toLowerCase()
              .compareTo(b.thMasuk.toString().toLowerCase());
        } else {
          return b.thMasuk
              .toString()
              .toLowerCase()
              .compareTo(a.thMasuk.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 4) {
      mahasiswa.sort((a, b) {
        if (isAscending) {
          return a.prodi
              .toString()
              .toLowerCase()
              .compareTo(b.prodi.toString().toLowerCase());
        } else {
          return b.prodi
              .toString()
              .toLowerCase()
              .compareTo(a.prodi.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 5) {
      mahasiswa.sort((a, b) {
        if (isAscending) {
          return a.email
              .toString()
              .toLowerCase()
              .compareTo(b.email.toString().toLowerCase());
        } else {
          return b.email
              .toString()
              .toLowerCase()
              .compareTo(a.email.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 6) {
      mahasiswa.sort((a, b) {
        if (isAscending) {
          return a.noTelp
              .toString()
              .toLowerCase()
              .compareTo(b.noTelp.toString().toLowerCase());
        } else {
          return b.noTelp
              .toString()
              .toLowerCase()
              .compareTo(a.noTelp.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 7) {
      mahasiswa.sort((a, b) {
        if (isAscending) {
          return a.username
              .toString()
              .toLowerCase()
              .compareTo(b.username.toString().toLowerCase());
        } else {
          return b.username
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

  _getData() async {
    setState(() {
      isLoading = true;
    });
    ServicesMahasiswa.getMahasiswas().then(
      (result) {
        setState(() {
          mahasiswa = result;
          isLoading = false;
        });
      },
    );
  }

  void onSearchTextChanged(String value) {
    setState(() {
      searchText = value;
      isLoading = false;
    });
  }

  List<Mahasiswa> getFilteredMahasiswas() {
    if (cariInput.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return mahasiswa;
    }
    setState(() {
      isLoading = false;
    });
    return mahasiswa
        .where((mahasiswa) =>
            mahasiswa.nim!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            mahasiswa.namaLengkap!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            mahasiswa.thMasuk!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            mahasiswa.prodi!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            mahasiswa.email!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            mahasiswa.noTelp!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase())||
            mahasiswa.username!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            mahasiswa.prodi!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()))
        .toList();
  }

  Future<void> _refreshData() async {
    await _getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    mahasiswa = [];
    _getData();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TambahMahasiswaWidget(
                        user: user,
                      )));
        },
        backgroundColor: kPrimaryColor,
        elevation: 8,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
      drawer: NavigationDrawerWidget(
        user: user,
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Data Mahasiswa',
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
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(200, 10, 10, 0),
                child: TextField(
                  controller: cariInput,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5.0),
                    hintText: 'Pencarian Data',
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
                  onChanged: (string) {
                    setState(() {
                      isLoading = true;
                    });
                    getFilteredMahasiswas();
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : PaginatedDataTable(
                            sortColumnIndex: sortIndex,
                            sortAscending: isAscending,
                            dataRowMaxHeight:
                                double.infinity, // Code to be changed.
                            columns: [
                              DataColumn(label: Text('No')),
                              DataColumn(label: Text('Foto')),
                              DataColumn(onSort: onSort, label: Text('Nama')),
                              DataColumn(
                                  onSort: onSort, label: Text('Tahun Masuk')),
                              DataColumn(
                                  onSort: onSort, label: Text('Program Studi')),
                              DataColumn(onSort: onSort, label: Text('Email')),
                              DataColumn(
                                  onSort: onSort, label: Text('Nomor Telepon')),
                              DataColumn(
                                  onSort: onSort, label: Text('Username')),
                              DataColumn(label: Text('Action')),
                            ],
                            source: DataSource(
                              context: context,
                              mahasiswa: getFilteredMahasiswas(),
                              updateCallback: _postData,
                              deleteCallback: _deleteData,
                            ),
                            rowsPerPage: 10,
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
}

class DataSource extends DataTableSource {
  final List<Mahasiswa> mahasiswa;
  final BuildContext context;
  final Function(Mahasiswa) updateCallback;
  final Function(Mahasiswa) deleteCallback;

  DataSource({
    required this.context,
    required this.mahasiswa,
    required this.deleteCallback,
    required this.updateCallback,
  });

  @override
  DataRow getRow(int index) {
    final no = index + 1;
    final Data = mahasiswa[index];
    return DataRow(cells: [
      DataCell(Text(no.toString())),
      DataCell(
        Container(
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                serviceNetwork.foto + Data.foto.toString(),
              ),
            ),
          ),
        ),
      ),
      DataCell(Text(Data.namaLengkap.toString())),
      DataCell(Text(Data.thMasuk.toString())),
      DataCell(Text(Data.prodi.toString())),
      DataCell(Text(Data.email.toString())),
      DataCell(Text(Data.noTelp.toString())),
      DataCell(Text(Data.username.toString())),
      DataCell(
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      width: 30,
                      child: IconButton(
                        icon: Icon(
                          Icons.update,
                          color: Colors.orange,
                          size: 30,
                        ),
                        onPressed: () {
                          updateCallback(Data);
                        },
                        padding: EdgeInsets.all(0),
                        color: Colors.orange[600],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      width: 30,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          deleteCallback(Data);
                        },
                        padding: EdgeInsets.all(0),
                        color: Colors.red[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => mahasiswa.length;

  @override
  int get selectedRowCount => 0;
}
