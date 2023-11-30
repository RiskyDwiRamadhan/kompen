import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/widget/Model/modelUser.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:kompen/widget/Service/serviceNetwork.dart';
import 'package:path/path.dart' as path;

class ServicesUser {
  static const ROOT = serviceNetwork.login;
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_DOSEN_ACTION = 'get_dosen';
  static const _GET_MAHASISWA_ACTION = 'get_mahasiswa';
  static const _ADD_ACTION = 'add_data';
  static const _UPDATE_ACTION = 'update';
  static const _DELETE_ACTION = 'Delete';

  // Menampilkan Data Dosen
  static Future<List<User>> getDosen(String username, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_DOSEN_ACTION;
      map['username'] = username;
      map['password'] = password;

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

  // Menampilkan Data Mahasiswa
  static Future<List<User>> getMahasiswa(String username, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_MAHASISWA_ACTION;
      map['username'] = username;
      map['password'] = password;

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

}
