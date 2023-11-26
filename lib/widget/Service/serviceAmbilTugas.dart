import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/widget/Model/modelAmbilTugas.dart';
import 'package:kompen/widget/Model/modelTugas.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:kompen/widget/Service/serviceNetwork.dart';

class ServicesAmbilTugas {
  static const ROOT = serviceNetwork.selesai;
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'get_all';
  static const _GET_READY_ACTION = 'get_ready';
  static const _GET_NIP_ACTION = 'get_nip';
  static const _GET_WHERE_TUGAS = 'where_get_tugas';
  static const _ADD_ACTION = 'add_data';
  static const _UPDATE_ACTION = 'update';
  static const _DELETE_ACTION = 'Delete';

  // Menampilkan Semua Data
  static Future<List<AmbilTugas>> getAmbilTugass(String idtugas) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_WHERE_TUGAS;
      map['id_tugas'] = idtugas;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getAmbilTugass Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
      return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <AmbilTugas>[]; // return an empty list on exception/error
    }
  }

  static List<AmbilTugas> parseData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<AmbilTugas> Tugass = list.map((model) => AmbilTugas.fromJson(model)).toList();
    return Tugass;
  }

  // Menambahkan data
  static Future<String> addTugas(String id_tugas, String nim, String kompen) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST",uri);
      
      request.fields['action'] = _ADD_ACTION;
      request.fields['id_tugas'] = id_tugas;
      request.fields['nim'] = nim;
      request.fields['kompen'] = kompen;

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
  static Future<String> updateTugas(String idTselesai) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST",uri);
      
      request.fields['action'] = _UPDATE_ACTION;
      request.fields['id_tselesai'] = idTselesai;

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
  static Future<String> deleteTugas(String idTselesai) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_ACTION;
      map['id_tselesai'] = idTselesai;
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
