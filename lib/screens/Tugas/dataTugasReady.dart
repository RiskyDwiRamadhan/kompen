import 'package:flutter/material.dart';
import 'package:kompen/Model/modelUser.dart';
import 'package:kompen/Service/serviceNetwork.dart';
import 'package:kompen/screens/Tugas/inputTugas.dart';
import 'package:kompen/screens/Tugas/updateTugas.dart';
import 'package:kompen/Model/modelTugas.dart';
import 'package:kompen/Service/serviceTugas.dart';
import 'package:kompen/componen/navigatorDrawer.dart';

class dataTugasReadyWidget extends StatefulWidget {
  final User user;
  const dataTugasReadyWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<dataTugasReadyWidget> createState() => _dataTugasReadyWidgetState();
}

class _dataTugasReadyWidgetState extends State<dataTugasReadyWidget> {
  late List<Tugas> tugas;
  int sortIndex = 0;
  bool isAscending = true;
  bool isLoading = false; // Track the loading state
  String searchText = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cariInput = new TextEditingController();
  late User user;
  void _getUser() async {
    user = widget.user;
  }

  _deleteData(Tugas tugas) {
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
    });
    ServicesTugas.getReady().then(
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
                              DataColumn(label: Text('Foto')),
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
                            ],
                            source: TugasDataSource(
                              context: context,
                              tugas: getFilteredTugass(),
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

  TugasDataSource({
    required this.context,
    required this.tugas,
  });

  @override
  DataRow getRow(int index) {
    final tugasData = tugas[index];
    return DataRow(cells: [
      DataCell(
        Container(
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                serviceNetwork.foto + tugasData.fotod.toString(),
              ),
            ),
          ),
        ),
      ),
      DataCell(Text(tugasData.namad.toString())),
      DataCell(Text(tugasData.judulTugas.toString())),
      DataCell(Text(tugasData.kategori.toString())),
      DataCell(Text(tugasData.tgl.toString())),
      DataCell(Text(tugasData.kuota.toString())),
      DataCell(Text(tugasData.jumlahKompen.toString())),
      DataCell(Text(tugasData.deskripsi.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tugas.length;

  @override
  int get selectedRowCount => 0;
}
