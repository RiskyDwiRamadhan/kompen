class Mahasiswa {
  String? nim;
  String? namaLengkap;
  String? thMasuk;
  String? prodi;
  String? jalurmasuk;
  String? email;
  String? noTelp;
  String? username;
  String? password;
  String? foto;
  String? terkompen;

  Mahasiswa(
      {this.nim,
      this.namaLengkap,
      this.thMasuk,
      this.prodi,
      this.jalurmasuk,
      this.email,
      this.noTelp,
      this.username,
      this.password,
      this.foto,
      this.terkompen});

  Mahasiswa.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    namaLengkap = json['nama_lengkap'];
    thMasuk = json['th_masuk'];
    prodi = json['prodi'];
    jalurmasuk = json['jalurmasuk'];
    email = json['email'];
    noTelp = json['no_telp'];
    username = json['username'];
    password = json['password'];
    foto = json['foto'];
    terkompen = json['terkompen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nim'] = this.nim;
    data['nama_lengkap'] = this.namaLengkap;
    data['th_masuk'] = this.thMasuk;
    data['prodi'] = this.prodi;
    data['jalurmasuk'] = this.jalurmasuk;
    data['email'] = this.email;
    data['no_telp'] = this.noTelp;
    data['username'] = this.username;
    data['password'] = this.password;
    data['foto'] = this.foto;
    data['terkompen'] = this.terkompen;
    return data;
  }
}
