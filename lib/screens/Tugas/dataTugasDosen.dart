import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kompen/screens/AmbilTugas/InputAmbilTugas.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/screens/Tugas/inputTugas.dart';
import 'package:kompen/screens/Tugas/updateTugas.dart';
import 'package:kompen/Model/modelTugas.dart';
import 'package:kompen/Service/serviceTugas.dart';
import 'package:kompen/componen/navigatorDrawer.dart';

class dataTugasDosenWidget extends StatefulWidget {
  final User user;
  const dataTugasDosenWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<dataTugasDosenWidget> createState() => _dataTugasDosenWidgetState();
}

class _dataTugasDosenWidgetState extends State<dataTugasDosenWidget> {
  late List<Tugas> tugas;

  int sortIndex = 0;
  String nip = "51188";
  bool isAscending = true;
  bool isLoading = false; // Track the loading state
  String searchText = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cariInput = new TextEditingController();

  late User user;
  File? _image;

  void _getUser() async {}

  _ambilTugas(Tugas tugas) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputAmbilTugasWidget(
          tugas: tugas,
          user: user,
        ),
      ),
    );
  }

  _postData(Tugas tugas) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTugasWidget(
          user: user,
          tugas: tugas,
        ),
      ),
    );
  }

  _updateStatus(Tugas tugas) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi Data"),
          content: Text("Apakah Anda Ingin Menutup Tugas ini ??"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                ServicesTugas.updateStatusTugas(tugas.idTugas.toString()).then(
                  (result) {
                    if ('success' == result) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Konfirmasi Data"),
                            content: Text("Tugas telah ditutup!!"),
                          );
                        },
                      );
                    }
                  },
                );
                setState(() {
                  _getData();
                });
                Navigator.of(context).pop();
              },
              child: Text('Ya'),
            )
          ],
        );
      },
    );
  }

  _deleteData(Tugas tugas) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi Data"),
          content: Text("Apakah Anda Ingin Menghapus Data Ini ??"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                ServicesTugas.deleteTugas(tugas.idTugas.toString()).then(
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
    if (sortIndex == 1) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.judulTugas
              .toString()
              .toLowerCase()
              .compareTo(b.judulTugas.toString().toLowerCase());
        } else {
          return b.judulTugas
              .toString()
              .toLowerCase()
              .compareTo(a.judulTugas.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 2) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.kategori
              .toString()
              .toLowerCase()
              .compareTo(b.kategori.toString().toLowerCase());
        } else {
          return b.kategori
              .toString()
              .toLowerCase()
              .compareTo(a.kategori.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 3) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.tgl
              .toString()
              .toLowerCase()
              .compareTo(b.tgl.toString().toLowerCase());
        } else {
          return b.tgl
              .toString()
              .toLowerCase()
              .compareTo(a.tgl.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 4) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.kuota
              .toString()
              .toLowerCase()
              .compareTo(b.kuota.toString().toLowerCase());
        } else {
          return b.kuota
              .toString()
              .toLowerCase()
              .compareTo(a.kuota.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 5) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.jumlahKompen
              .toString()
              .toLowerCase()
              .compareTo(b.jumlahKompen.toString().toLowerCase());
        } else {
          return b.jumlahKompen
              .toString()
              .toLowerCase()
              .compareTo(a.jumlahKompen.toString().toLowerCase());
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
      user = widget.user;
      nip = widget.user.idUser!.toString();
    });
    ServicesTugas.getTDosens(nip, 'Ready').then(
      (result) {
        setState(() {
          isLoading = false;
          tugas = result;
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

  List<Tugas> getFilteredTugass() {
    if (cariInput.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return tugas;
    }
    setState(() {
      isLoading = false;
    });
    return tugas
        .where((tugas) =>
            tugas.namad!.toLowerCase().contains(cariInput.text.toLowerCase()) ||
            tugas.judulTugas!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            tugas.kategori!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            tugas.tgl!.toLowerCase().contains(cariInput.text.toLowerCase()) ||
            tugas.kuota!.toLowerCase().contains(cariInput.text.toLowerCase()) ||
            tugas.jumlahKompen!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            tugas.deskripsi!
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
    tugas = [];
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
                  builder: (context) => TambahTugasWidget(
                        user: user,
                      )));
        },
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
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
        backgroundColor: Color.fromRGBO(16, 6, 148, 1),
        title: Text(
          'Data Tugas',
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
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (string) {
                    setState(() {
                      isLoading = true;
                    });
                    getFilteredTugass();
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    isLoading
                        ? CircularProgressIndicator()
                        : PaginatedDataTable(
                            sortColumnIndex: sortIndex,
                            sortAscending: isAscending,
                            dataRowMaxHeight:
                                double.infinity, // Code to be changed.
                            dataRowMinHeight: 60,
                            columns: [
                              DataColumn(label: Text('No')),
                              DataColumn(
                                  onSort: onSort, label: Text('Pemberi Tugas')),
                              DataColumn(
                                  onSort: onSort, label: Text('Judul Tugas')),
                              DataColumn(
                                  onSort: onSort, label: Text('Kategori')),
                              DataColumn(
                                  onSort: onSort, label: Text('Tanggal')),
                              DataColumn(onSort: onSort, label: Text('Kuota')),
                              DataColumn(
                                  onSort: onSort, label: Text('Jumlah Kompen')),
                              DataColumn(
                                  onSort: onSort, label: Text('Deskripsi')),
                              DataColumn(label: Text('Action')),
                            ],
                            source: TugasDataSource(
                              context: context,
                              tugas: getFilteredTugass(),
                              updateCallback: _postData,
                              updateStatusTugasCallback: _updateStatus,
                              deleteCallback: _deleteData,
                              ambilTugasCallback: _ambilTugas,
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

class TugasDataSource extends DataTableSource {
  final List<Tugas> tugas;
  final BuildContext context;
  final Function(Tugas) updateCallback;
  final Function(Tugas) updateStatusTugasCallback;
  final Function(Tugas) deleteCallback;
  final Function(Tugas) ambilTugasCallback;

  TugasDataSource({
    required this.context,
    required this.tugas,
    required this.deleteCallback,
    required this.updateCallback,
    required this.updateStatusTugasCallback,
    required this.ambilTugasCallback,
  });

  @override
  DataRow getRow(int index) {
    final no = index + 1;
    final tugasData = tugas[index];
    return DataRow(cells: [
      DataCell(Text(no.toString())),
      DataCell(Text(tugasData.namad.toString())),
      DataCell(Text(tugasData.judulTugas.toString())),
      DataCell(Text(tugasData.kategori.toString())),
      DataCell(Text(tugasData.tgl.toString())),
      DataCell(Text(tugasData.kuota.toString())),
      DataCell(Text(tugasData.jumlahKompen.toString())),
      DataCell(Text(tugasData.deskripsi.toString())),
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
                          updateCallback(tugasData);
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
                          deleteCallback(tugasData);
                        },
                        padding: EdgeInsets.all(0),
                        color: Colors.red[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                          Icons.library_add,
                          color: const Color.fromARGB(255, 75, 233, 80),
                          size: 30,
                        ),
                        onPressed: () {
                          ambilTugasCallback(tugasData);
                        },
                        padding: EdgeInsets.all(0),
                        color: const Color.fromARGB(255, 75, 233, 80),
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
                          Icons.close,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        onPressed: () {
                          updateStatusTugasCallback(tugasData);
                        },
                        padding: EdgeInsets.all(0),
                        color: Colors.yellow,
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
  int get rowCount => tugas.length;

  @override
  int get selectedRowCount => 0;
}
