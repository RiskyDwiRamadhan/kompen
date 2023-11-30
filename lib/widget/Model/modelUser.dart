class User {
  String? idUser;
  String? namaLengkap;
  String? username;
  String? password;
  String? email;
  String? noTelp;
  String? foto;
  String? status;

  User(
      {this.idUser,
      this.namaLengkap,
      this.username,
      this.password,
      this.email,
      this.noTelp,
      this.foto,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    namaLengkap = json['nama_lengkap'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    noTelp = json['no_telp'];
    foto = json['foto'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['nama_lengkap'] = this.namaLengkap;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['no_telp'] = this.noTelp;
    data['foto'] = this.foto;
    data['status'] = this.status;
    return data;
  }
}
