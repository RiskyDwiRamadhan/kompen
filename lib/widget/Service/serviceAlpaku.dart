import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:kompen/widget/Model/modelAlpaku.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:kompen/widget/Model/modelDetailAlpa.dart';
import 'package:kompen/widget/Service/serviceNetwork.dart';
import 'package:path/path.dart' as path;

class ServicesAlpaku {
  static const ROOT = serviceNetwork.alpaku;
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'get_all';
  static const _GET_WHERE_ACTION = 'get_where';
  static const _GET_DETAIL_ACTION = 'get_detail';
  static const _ADD_ACTION = 'add_data';
  static const _UPDATE_ACTION = 'update';
  static const _DELETE_ACTION = 'Delete';
  static late List<Alpaku> list;

  // Menampilkan Semua Data
  static Future<List<Alpaku>> getAlpakus() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getAlpakus Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
      return compute(parseData, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <Alpaku>[]; // return an empty list on exception/error
    }
  }

  // Menampilkan Data Sesuai Nim
  static Future<List<Alpaku>> getAlpakuWhere(String nim) async {
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
      return <Alpaku>[]; // return an empty list on exception/error
    }
  }

  // Menampilkan Data Sesuai Nim
  static Future<List<DetailAlpa>> getDetailAlpaku(String nim, String semester) async {
     try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_DETAIL_ACTION;
      map['nim'] = nim;
      map['semester'] = semester;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getMahasiswas Response: ${response.body}');
      if (response.statusCode == 200) {
        print(response.body.length);
        print("Data ada banyak");
      return compute(parseDetail, response.body);
      } else {
        throw Exception('Can\'t get data');
      }
    } catch (e) {
      return <DetailAlpa>[]; // return an empty list on exception/error
    }
  }

  static List<Alpaku> parseData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Alpaku> Alpakus = list.map((model) => Alpaku.fromJson(model)).toList();
    return Alpakus;
  }

  static List<DetailAlpa> parseDetail(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<DetailAlpa> _DetailAlpa = list.map((model) => DetailAlpa.fromJson(model)).toList();
    return _DetailAlpa;
  }
}
