class DetailAlpa {
  String? idAlpa;
  String? nim;
  String? jamAlpa;
  String? menitAlpa;
  String? jamSakit;
  String? menitSakit;
  String? jamIjin;
  String? menitIjin;
  String? semester;

  DetailAlpa(
      {this.idAlpa,
      this.nim,
      this.jamAlpa,
      this.menitAlpa,
      this.jamSakit,
      this.menitSakit,
      this.jamIjin,
      this.menitIjin,
      this.semester});

  DetailAlpa.fromJson(Map<String, dynamic> json) {
    idAlpa = json['id_alpa'];
    nim = json['nim'];
    jamAlpa = json['jamAlpa'];
    menitAlpa = json['menitAlpa'];
    jamSakit = json['jamSakit'];
    menitSakit = json['menitSakit'];
    jamIjin = json['jamIjin'];
    menitIjin = json['menitIjin'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_alpa'] = this.idAlpa;
    data['nim'] = this.nim;
    data['jamAlpa'] = this.jamAlpa;
    data['menitAlpa'] = this.menitAlpa;
    data['jamSakit'] = this.jamSakit;
    data['menitSakit'] = this.menitSakit;
    data['jamIjin'] = this.jamIjin;
    data['menitIjin'] = this.menitIjin;
    data['semester'] = this.semester;
    return data;
  }
}
