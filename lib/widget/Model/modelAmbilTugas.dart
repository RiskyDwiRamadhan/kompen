class AmbilTugas {
  String? idTselesai;
  String? idTugas;
  String? namad;
  String? judulTugas;
  String? kategori;
  String? tglSelesai;
  String? kuota;
  String? jumlahKompen;
  String? deskripsi;
  String? namam;
  String? terkompen;
  String? status;

  AmbilTugas(
      {this.idTselesai,
      this.idTugas,
      this.namad,
      this.judulTugas,
      this.kategori,
      this.tglSelesai,
      this.kuota,
      this.jumlahKompen,
      this.deskripsi,
      this.namam,
      this.terkompen,
      this.status});

  AmbilTugas.fromJson(Map<String, dynamic> json) {
    idTselesai = json['id_tselesai'];
    idTugas = json['id_tugas'];
    namad = json['namad'];
    judulTugas = json['judul_tugas'];
    kategori = json['kategori'];
    tglSelesai = json['tgl_selesai'];
    kuota = json['kuota'];
    jumlahKompen = json['jumlah_kompen'];
    deskripsi = json['deskripsi'];
    namam = json['namam'];
    terkompen = json['terkompen'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tselesai'] = this.idTselesai;
    data['id_tugas'] = this.idTugas;
    data['namad'] = this.namad;
    data['judul_tugas'] = this.judulTugas;
    data['kategori'] = this.kategori;
    data['tgl_selesai'] = this.tglSelesai;
    data['kuota'] = this.kuota;
    data['jumlah_kompen'] = this.jumlahKompen;
    data['deskripsi'] = this.deskripsi;
    data['namam'] = this.namam;
    data['terkompen'] = this.terkompen;
    data['status'] = this.status;
    return data;
  }
}
