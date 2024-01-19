import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kompen/constants.dart';
import 'package:kompen/screens/Dosen/tambahDosen.dart';
import 'package:kompen/screens/Dosen/updateDosen.dart';
import 'package:kompen/Model/modelDosen.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceDosen.dart';
import 'package:kompen/Service/serviceNetwork.dart';
import 'package:kompen/componen/navigatorDrawer.dart';

class dataDosenWidget extends StatefulWidget {
  final User user;
  const dataDosenWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<dataDosenWidget> createState() => _dataDosenWidgetState();
}

class _dataDosenWidgetState extends State<dataDosenWidget> {
  late List<Dosen> dosen;
  int sortIndex = 0;
  bool isAscending = true;
  bool isLoading = false; // Track the loading state
  String searchText = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cariInput = new TextEditingController();
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

  void _getUser() async {
    user = widget.user;
    id_user = user.idUser.toString();
    nama = user.namaLengkap!.toString();
    noTelp = user.noTelp!.toString();
    password = user.password!.toString();
    username = user.username!.toString();
    email = user.email!.toString();
    foto = user.foto!.toString();
    status = user.status!.toString();
    _image = File(widget.user.foto!.toString());
  }

  _postData(Dosen dosen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDosenWidget(
          user: user,
          dosen: dosen,
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
    } else if (sortIndex == 3) {
      dosen.sort((a, b) {
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
    } else if (sortIndex == 4) {
      dosen.sort((a, b) {
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
    } else if (sortIndex == 5) {
      dosen.sort((a, b) {
        if (isAscending) {
          return a.level
              .toString()
              .toLowerCase()
              .compareTo(b.level.toString().toLowerCase());
        } else {
          return b.level
              .toString()
              .toLowerCase()
              .compareTo(a.level.toString().toLowerCase());
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
    ServicesDosen.getDosens().then(
      (result) {
        setState(() {
          dosen = result;
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

  List<Dosen> getFilteredDosens() {
    if (cariInput.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return dosen;
    }
    setState(() {
      isLoading = false;
    });
    return dosen
        .where((dosen) =>
            dosen.nip!.toLowerCase().contains(cariInput.text.toLowerCase()) ||
            dosen.namaLengkap!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            dosen.username!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            dosen.email!.toLowerCase().contains(cariInput.text.toLowerCase()) ||
            dosen.level!.toLowerCase().contains(cariInput.text.toLowerCase()))
        .toList();
  }

  Future<void> _refreshData() async {
    await _getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    dosen = [];
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
              builder: (context) => TambahDosenWidget(
                user: user,
              ),
            ),
          );
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 136, 135, 135),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                    getFilteredDosens();
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
                                  onSort: onSort, label: Text('Username')),
                              DataColumn(onSort: onSort, label: Text('Email')),
                              DataColumn(onSort: onSort, label: Text('Level')),
                              DataColumn(label: Text('Action')),
                            ],
                            source: DataSource(
                              context: context,
                              dosen: getFilteredDosens(),
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
  final List<Dosen> dosen;
  final BuildContext context;
  final Function(Dosen) updateCallback;
  final Function(Dosen) deleteCallback;

  DataSource({
    required this.context,
    required this.dosen,
    required this.deleteCallback,
    required this.updateCallback,
  });

  @override
  DataRow getRow(int index) {
    final no = index + 1;
    final Data = dosen[index];
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
      DataCell(Text(Data.username.toString())),
      DataCell(Text(Data.email.toString())),
      DataCell(Text(Data.level.toString())),
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
  int get rowCount => dosen.length;

  @override
  int get selectedRowCount => 0;
}
