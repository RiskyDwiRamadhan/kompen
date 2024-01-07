class Alpaku {
  String? idAlpa;
  String? nim;
  String? jmlAlpa;
  String? semester;
  List perkalian = [1,2,4,8,16,32,64,128,256,512,1024,2048];

  Alpaku({this.idAlpa, this.nim, this.jmlAlpa, this.semester});

  Alpaku.fromJson(Map<String, dynamic> json) {
    idAlpa = json['id_alpa'];
    nim = json['nim'];
    jmlAlpa = json['jml_alpa'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_alpa'] = this.idAlpa;
    data['nim'] = this.nim;
    data['jml_alpa'] = this.jmlAlpa;
    data['semester'] = this.semester;
    return data;
  }
}
