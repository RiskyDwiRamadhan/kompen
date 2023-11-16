import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/widget/Model/modelDosen.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class ServicesDosen {
  static const ROOT = 'http://192.168.1.200/kompen/Dosen.php';
  // static const ROOT = 'http://192.168.213.213/kompen/Dosen.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'get_all';
  static const _GET_WHERE_ACTION = 'get_where';
  static const _ADD_ACTION = 'add_data';
  static const _UPDATE_ACTION = 'update';
  static const _DELETE_ACTION = 'Delete';

  // Menampilkan Semua Data
  static Future<List<Dosen>> getDosens() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      // final response = await http.get(Uri.parse('http://192.168.1.200/kompen/dataM.php'));
      // final response = await http.get(Uri.parse('http://192.168.213.213/kompen/dataM.php'));
      print('getDosens Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
      return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Dosen>[]; // return an empty list on exception/error
    }
  }

  static List<Dosen> parseData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Dosen> dosens = list.map((model) => Dosen.fromJson(model)).toList();
    return dosens;
  }

  // Menambahkan data
  static Future<String> addDosen(String nip, String nama, String username,
      String password, String email, File foto, String status) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST",uri);
      
      request.fields['action'] = _ADD_ACTION;
      request.fields['nip'] = nip;
      request.fields['nama'] = nama;
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['email'] = email;
      request.fields['status'] = status;

      
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
  static Future<String> updateDosen(String nip, String nama, String username,
      String password, String email, File foto, String status) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST",uri);
      
      request.fields['action'] = _UPDATE_ACTION;
      request.fields['nip'] = nip;
      request.fields['nama'] = nama;
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['email'] = email;
      request.fields['status'] = status;

      
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
      return "error";
    }
  }

  // Delete Data
  static Future<String> deleteDosen(String nip) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_ACTION;
      map['nip'] = nip;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteDosen Response: ${response.body}');
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
