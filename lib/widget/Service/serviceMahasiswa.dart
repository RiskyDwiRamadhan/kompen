import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/widget/Model/modelMahasiswa.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:kompen/widget/Service/serviceNetwork.dart';
import 'package:path/path.dart' as path;

class ServicesMahasiswa {
  static const ROOT = serviceNetwork.mahasiswa;
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'get_all';
  static const _GET_ALPA_ACTION = 'alpa_mahasiswa';
  static const _GET_WHERE_ACTION = 'get_where';
  static const _ADD_ACTION = 'add_data';
  static const _UPDATE_ACTION = 'update';
  static const _DELETE_ACTION = 'Delete';

  // Menampilkan Semua Data
  static Future<List<Mahasiswa>> getMahasiswas() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      // final response = await http.get(Uri.parse('http://192.168.1.200/kompen/dataM.php'));
      // final response = await http.get(Uri.parse('http://192.168.213.213/kompen/dataM.php'));
      print('getMahasiswas Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
        return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Mahasiswa>[]; // return an empty list on exception/error
    }
  }

  // Menampilkan Semua Data
  static Future<List<Mahasiswa>> getMahasiswa(String nim) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_WHERE_ACTION;
      map['nim'] = nim;
      final response = await http.post(Uri.parse(ROOT), body: map);
      // final response = await http.get(Uri.parse('http://192.168.1.200/kompen/dataM.php'));
      // final response = await http.get(Uri.parse('http://192.168.213.213/kompen/dataM.php'));
      print('getMahasiswas Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
        return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Mahasiswa>[]; // return an empty list on exception/error
    }
  }

  // Menampilkan Semua Data
  static Future<List<Mahasiswa>> getAlpaMahasiswa(String nim) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALPA_ACTION;
      map['nim'] = nim;
      final response = await http.post(Uri.parse(ROOT), body: map);

      print('getMahasiswas Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
        return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Mahasiswa>[]; // return an empty list on exception/error
    }
  }

  static List<Mahasiswa> parseData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Mahasiswa> Mahasiswas =
        list.map((model) => Mahasiswa.fromJson(model)).toList();
    return Mahasiswas;
  }

  // Menambahkan data
  static Future<String> addMahasiswa(
      String nim,
      String nama,
      String prodi,
      String no_telp,
      String username,
      String password,
      String email,
      File foto,
      String th_masuk) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST", uri);

      request.fields['action'] = _ADD_ACTION;
      request.fields['nim'] = nim;
      request.fields['nama'] = nama;
      request.fields['prodi'] = prodi;
      request.fields['no_telp'] = no_telp;
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['email'] = email;
      request.fields['th_masuk'] = th_masuk;

      if (foto != null) {
        var stream = http.ByteStream(DelegatingStream.typed(foto.openRead()));
        var length = await foto.length();

        request.files.add(http.MultipartFile("foto", stream, length,
            filename: path.basename(foto.path)));
      }

      var response = await request.send();
      if (response.statusCode > 2) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return ("Error $e");
    }
  }

  // Update Data
  static Future<String> updateMahasiswa(
      String nim,
      String nama,
      String prodi,
      String no_telp,
      String username,
      String password,
      String email,
      File foto,
      String th_masuk) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST", uri);

      request.fields['action'] = _UPDATE_ACTION;
      request.fields['nim'] = nim;
      request.fields['nama'] = nama;
      request.fields['prodi'] = prodi;
      request.fields['no_telp'] = no_telp;
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['email'] = email;
      request.fields['th_masuk'] = th_masuk;

      if (foto != null) {
        print("$foto foto ada");

        if (File(foto.path).existsSync()) {
          print("$foto foto path ada");
          var stream = http.ByteStream(DelegatingStream.typed(foto.openRead()));
          var length = await foto.length();

          request.files.add(http.MultipartFile("foto", stream, length,
              filename: path.basename(foto.path)));
        } else {
          print("$foto foto path tidak ada");
          request.fields['foto'] = foto.toString();
        }
      }
      print("$foto foto kosong");
      var response = await request.send();
      if (response.statusCode == 200) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Delete Data
  static Future<String> deleteMahasiswa(String nim) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_ACTION;
      map['nim'] = nim;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteMahasiswa Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
