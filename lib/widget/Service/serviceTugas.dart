import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/widget/Model/modelTugas.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:kompen/widget/Service/serviceNetwork.dart';

class ServicesTugas {
  static const ROOT = serviceNetwork.tugas;
  static const _GET_ALL_ACTION = 'get_all';
  static const _GET_READY_ACTION = 'get_ready';
  static const _GET_NIP_ACTION = 'where_nip';
  static const _GET_WHERE_ACTION = 'get_where';
  static const _ADD_ACTION = 'add_data';
  static const _UPDATE_ACTION = 'update';
  static const _UPDATE_STATUS_ACTION = 'update_status';
  static const _DELETE_ACTION = 'Delete';

  // Menampilkan Semua Data
  static Future<List<Tugas>> getTugass() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getTugass Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
      return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Tugas>[]; // return an empty list on exception/error
    }
  }

  // Menampilkan Semua Data
  static Future<List<Tugas>> getReady() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_READY_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getReady Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
      return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Tugas>[]; // return an empty list on exception/error
    }
  }

  // Menampilkan Data Sesuai NIP
  static Future<List<Tugas>> getTDosens(String nip) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_NIP_ACTION;
      map['nip'] = nip;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getTugass Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
      return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Tugas>[]; // return an empty list on exception/error
    }
  }

  static List<Tugas> parseData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Tugas> Tugass = list.map((model) => Tugas.fromJson(model)).toList();
    return Tugass;
  }

  // Menambahkan data
  static Future<String> addTugas(String nip, String judul, String kategori,String kuota, 
                        String kompen,String deskripsi) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST",uri);
      
      request.fields['action'] = _ADD_ACTION;
      request.fields['nip'] = nip;
      request.fields['judul_tugas'] = judul;
      request.fields['kategori'] = kategori;
      request.fields['kuota'] = kuota;
      request.fields['jumlah_kompen'] = kompen;
      request.fields['deskripsi'] = deskripsi;

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
  static Future<String> updateTugas(String idtugas, String judul, String kategori,String kuota, 
                        String kompen,String deskripsi) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST",uri);
      
      request.fields['action'] = _UPDATE_ACTION;
      request.fields['id_tugas'] = idtugas;
      request.fields['judul_tugas'] = judul;
      request.fields['kategori'] = kategori;
      request.fields['kuota'] = kuota;
      request.fields['jumlah_kompen'] = kompen;
      request.fields['deskripsi'] = deskripsi;

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
  
  // Update Status Tugas
  static Future<String> updateStatusTugas(String idtugas) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST",uri);
      
      request.fields['action'] = _UPDATE_STATUS_ACTION;
      request.fields['id_tugas'] = idtugas;

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
  static Future<String> deleteTugas(String idtugas) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_ACTION;
      map['id_tugas'] = idtugas;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteTugas Response: ${response.body}');
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
