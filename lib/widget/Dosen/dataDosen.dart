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
  bool isLoading = false; // Track the loading state
  String searchText = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cariInput = new TextEditingController();

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
                _getData();
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
    } else if (sortIndex == 2) {
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
    } else if (sortIndex == 3) {
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
    } else if (sortIndex == 4) {
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

  @override
  void initState() {
    super.initState();
    dosen = [];
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(200, 10, 0, 0),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    isLoading
                        ? CircularProgressIndicator()
                        : DataTable(
                            sortColumnIndex: sortIndex,
                            sortAscending: isAscending,
                            dataRowMaxHeight:
                                double.infinity, // Code to be changed.
                            columns: [
                              DataColumn(label: Text('Foto')),
                              DataColumn(onSort: onSort, label: Text('Nama')),
                              DataColumn(
                                  onSort: onSort, label: Text('Username')),
                              DataColumn(onSort: onSort, label: Text('Email')),
                              DataColumn(onSort: onSort, label: Text('Level')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: getFilteredDosens()
                                .map((e) => DataRow(cells: [
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  'http://192.168.1.200/kompen/uploads/' +
                                                      e.foto.toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(e.namaLengkap.toString())),
                                      DataCell(Text(e.username.toString())),
                                      DataCell(Text(e.email.toString())),
                                      DataCell(Text(e.level.toString())),
                                      DataCell(
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              child: GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  width: 30,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.update,
                                                      color: Colors.orange,
                                                      size: 30,
                                                    ),
                                                    onPressed: () {
                                                      _postData(e);
                                                    },
                                                    padding: EdgeInsets.all(0),
                                                    color: Colors.orange[600],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              child: GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  width: 30,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                    onPressed: () {
                                                      _deleteData(e);
                                                    },
                                                    padding: EdgeInsets.all(0),
                                                    color: Colors.red[600],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]))
                                .toList(),
                            dataRowMinHeight: 40,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
