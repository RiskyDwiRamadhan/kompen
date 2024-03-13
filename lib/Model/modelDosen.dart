class Dosen {
  String? nip;
  String? namaLengkap;
  String? username;
  String? email;
  String? password;
  String? no_telp;
  String? foto;
  String? level;

  Dosen(
      {this.nip,
      this.namaLengkap,
      this.username,
      this.password,
      this.email,
      this.no_telp,
      this.foto,
      this.level});

  Dosen.fromJson(Map<String, dynamic> json) {
    nip = json['nip'];
    namaLengkap = json['nama_lengkap'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    no_telp = json['no_telp'];
    foto = json['foto'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nip'] = this.nip;
    data['nama_lengkap'] = this.namaLengkap;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['no_telp'] = this.no_telp;
    data['foto'] = this.foto;
    data['level'] = this.level;
    return data;
  }
}
