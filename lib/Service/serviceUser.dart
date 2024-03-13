import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/Model/modelUser.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:kompen/Service/serviceNetwork.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class ServicesUser {
  static const ROOT = serviceNetwork.login;
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_DOSEN_ACTION = 'get_dosen';
  static const _GET_MAHASISWA_ACTION = 'get_mahasiswa';
  static const _GET_ALPA_ACTION = 'get_alpa';
  static const _UPDATE_DOSEN = 'update_dosen';
  static const _UPDATE_MAHASISWA = 'update_mahasiswa';

  // Menampilkan Data Mahasiswa
  static Future<List<User>> getAlpa(String nim) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALPA_ACTION;
      map['nim'] = nim;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getUser Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
        return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <User>[]; // return an empty list on exception/error
    }
  }

  static List<User> parseData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<User> Users = list.map((model) => User.fromJson(model)).toList();
    return Users;
  }

  // Get Data User
  static  Future<List<User>> getUser(
      String username, String password, String status) async {
    try {
      var map = Map<String, dynamic>();
      var uri = Uri.parse(ROOT);
      if (status == "Mahasiswa") {
        map['action'] = _GET_MAHASISWA_ACTION;
      } else {
        map['action'] = _GET_DOSEN_ACTION;
      }
      map['username'] = username;
      map['password'] = password;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Data Login");
      print(response.body);
      if (response.statusCode == 200) {
        return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <User>[]; // return an empty list on exception/error
    }
  }

  // Update Data User
  static Future<String> updateUser(
      String idUser,
      String nama,
      String username,
      String password,
      String email,
      String no_telp,
      File foto,
      String status) async {
    try {
      var uri = Uri.parse(ROOT);
      final request = http.MultipartRequest("POST", uri);
      if (status == "Mahasiswa") {
        request.fields['action'] = _UPDATE_MAHASISWA;
      } else {
        request.fields['action'] = _UPDATE_DOSEN;
      }
      request.fields['idUser'] = idUser;
      request.fields['nama'] = nama;
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['email'] = email;
      request.fields['no_telp'] = no_telp;

      if (foto != null) {
        var stream = http.ByteStream(DelegatingStream.typed(foto.openRead()));
        var length = await foto.length();

        request.files.add(http.MultipartFile("foto", stream, length,
            filename: path.basename(foto.path)));
      }

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

  static Future<void> setdata(
      String status, String username, String password) async {
    final sharedPref = await SharedPreferences.getInstance();

    final myDataPref = json.encode({
      'nTabel': status,
      'username': username,
      'password': password,
    });

    sharedPref.setString('myData', myDataPref);
  }
}
