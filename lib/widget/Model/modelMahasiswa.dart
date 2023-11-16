class Mahasiswa {
  String? nim;
  String? namaLengkap;
  String? prodi;
  String? noTelp;
  String? thMasuk;
  String? username;
  String? password;
  String? email;
  String? foto;

  Mahasiswa(
      {this.nim,
      this.namaLengkap,
      this.prodi,
      this.noTelp,
      this.thMasuk,
      this.username,
      this.password,
      this.email,
      this.foto});

  Mahasiswa.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    namaLengkap = json['nama_lengkap'];
    prodi = json['prodi'];
    noTelp = json['no_telp'];
    thMasuk = json['th_masuk'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nim'] = this.nim;
    data['nama_lengkap'] = this.namaLengkap;
    data['prodi'] = this.prodi;
    data['no_telp'] = this.noTelp;
    data['th_masuk'] = this.thMasuk;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['foto'] = this.foto;
    return data;
  }
}
