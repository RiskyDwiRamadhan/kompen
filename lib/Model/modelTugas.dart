class Tugas {
  String? idTugas;
  String? fotod;
  String? fotom;
  String? namad;
  String? namam;
  String? judulTugas;
  String? kategori;
  String? tgl;
  String? kuota;
  String? jumlahKompen;
  String? deskripsi;

  Tugas(
      {this.idTugas,
      this.fotod,
      this.fotom,
      this.namad,
      this.namam,
      this.judulTugas,
      this.kategori,
      this.tgl,
      this.kuota,
      this.jumlahKompen,
      this.deskripsi});

  Tugas.fromJson(Map<String, dynamic> json) {
    idTugas = json['id_tugas'];
    fotod = json['fotod'];
    fotom = json['fotom'];
    namad = json['namad'];
    namam = json['namam'];
    judulTugas = json['judul_tugas'];
    kategori = json['kategori'];
    tgl = json['tgl'];
    kuota = json['kuota'];
    jumlahKompen = json['jumlah_kompen'];
    deskripsi = json['deskripsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tugas'] = this.idTugas;
    data['fotod'] = this.fotod;
    data['fotom'] = this.fotom;
    data['namad'] = this.namad;
    data['namam'] = this.namam;
    data['judul_tugas'] = this.judulTugas;
    data['kategori'] = this.kategori;
    data['tgl'] = this.tgl;
    data['kuota'] = this.kuota;
    data['jumlah_kompen'] = this.jumlahKompen;
    data['deskripsi'] = this.deskripsi;
    return data;
  }
}
