import 'package:flutter/material.dart';
import 'package:kompen/widget/AmbilTugas/tambahMahasiswaKompen.dart';
import 'package:kompen/widget/Model/modelAmbilTugas.dart';
import 'package:kompen/widget/Service/serviceAmbilTugas.dart';
import 'package:kompen/widget/Tugas/inputTugas.dart';
import 'package:kompen/widget/Tugas/updateTugas.dart';
import 'package:kompen/widget/Model/modelTugas.dart';
import 'package:kompen/widget/Model/modelTugas.dart';
import 'package:kompen/widget/Service/serviceTugas.dart';
import 'package:kompen/widget/Service/serviceTugas.dart';
import 'package:kompen/widget/Tugas/updateTugas.dart';

class dataAmbilTugasWidget extends StatefulWidget {
  final id_tugas;
  const dataAmbilTugasWidget({Key? key, required this.id_tugas})
      : super(key: key);

  @override
  State<dataAmbilTugasWidget> createState() => _dataAmbilTugasWidgetState();
}

class _dataAmbilTugasWidgetState extends State<dataAmbilTugasWidget> {
  List<AmbilTugas> tugas = [];
  String idtugas = "";
  int sortIndex = 0;
  bool isAscending = true;
  bool isLoading = false; // Track the loading state
  String searchText = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cariInput = new TextEditingController();

  _postData(AmbilTugas ambilTugas) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi Data"),
          content: Text("Apakah Mahasiswa Sudah Melakukan Kompen ??"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                ServicesAmbilTugas.updateTugas(ambilTugas.idTselesai.toString())
                    .then(
                  (result) {
                    if ('success' == result) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Konfirmasi Data"),
                            content:
                                Text("Mahasiswa Telah Menyelesaikan Kompen!!"),
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

  _deleteData(AmbilTugas ambilTugas) {
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
                ServicesAmbilTugas.deleteTugas(ambilTugas.idTselesai.toString())
                    .then(
                  (result) {
                    if ('Succes' == result) {
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

  sortData() {
    if (sortIndex == 1) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.namam
              .toString()
              .toLowerCase()
              .compareTo(b.namam.toString().toLowerCase());
        } else {
          return b.namam
              .toString()
              .toLowerCase()
              .compareTo(a.namam.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 3) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.tglSelesai
              .toString()
              .toLowerCase()
              .compareTo(b.tglSelesai.toString().toLowerCase());
        } else {
          return b.tglSelesai
              .toString()
              .toLowerCase()
              .compareTo(a.tglSelesai.toString().toLowerCase());
        }
      });
    } else if (sortIndex == 4) {
      tugas.sort((a, b) {
        if (isAscending) {
          return a.status
              .toString()
              .toLowerCase()
              .compareTo(b.status.toString().toLowerCase());
        } else {
          return b.status
              .toString()
              .toLowerCase()
              .compareTo(a.status.toString().toLowerCase());
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
      idtugas = widget.id_tugas!.toString();
    });
    ServicesAmbilTugas.getAmbilTugass(idtugas).then(
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

  List<AmbilTugas> getFilteredTugass() {
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
            tugas.namam!.toLowerCase().contains(cariInput.text.toLowerCase()) ||
            tugas.tglSelesai!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            tugas.status!
                .toLowerCase()
                .contains(cariInput.text.toLowerCase()) ||
            tugas.jumlahKompen!
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
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
                  getFilteredTugass();
                },
              ),
            ),
            SizedBox(
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
                                onSort: onSort, label: Text('Mahasiswa')),
                            DataColumn(label: Text('Kompen')),
                            DataColumn(onSort: onSort, label: Text('Tanggal')),
                            DataColumn(onSort: onSort, label: Text('Status')),
                            DataColumn(onSort: onSort, label: Text('Kuota')),
                            DataColumn(label: Text('Action')),
                          ],
                          source: TugasDataSource(
                            context: context,
                            tugas: getFilteredTugass(),
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
    );
  }
}

class TugasDataSource extends DataTableSource {
  final List<AmbilTugas> tugas;
  final BuildContext context;
  final Function(AmbilTugas) updateCallback;
  final Function(AmbilTugas) deleteCallback;

  TugasDataSource({
    required this.context,
    required this.tugas,
    required this.deleteCallback,
    required this.updateCallback,
  });

  @override
  DataRow getRow(int index) {
    final no = index + 1;
    final tugasData = tugas[index];
    return DataRow(cells: [
      DataCell(Text(no.toString())),
      DataCell(Text(tugasData.namam.toString())),
      DataCell(Text(tugasData.terkompen.toString())),
      DataCell(Text(tugasData.tglSelesai.toString())),
      DataCell(Text(tugasData.status.toString())),
      DataCell(Text(tugasData.kuota.toString())),
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
