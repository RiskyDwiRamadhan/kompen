import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/Model/modelDosen.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class ServicesTest {
  static const ROOT = 'http://192.168.1.200/kompen/test.php';
  // static const ROOT = 'http://192.168.213.213/kompen/registerDosen.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'get_all';
  static const _GET_WHERE_ACTION = 'get_where';
  static const _ADD_ACTION = 'register';
  static const _UPDATE_ACTION = 'update';
  static const _DELETE_ACTION = 'Delete';
  
  // Menambahkan data
  static Future<String> addDosenCoba(String nip, String nama, String username,
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


} 