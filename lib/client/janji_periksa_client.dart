import 'dart:convert';

import 'package:http/http.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';

class JanjiPeriksaClient {
  // untuk emulator
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/janjiperiksa';

  // untuk hp
  // static final String url = '192.168.1.14';
  // static final String endpoint = '/GD_API_1180/public/api/User';

  static Future<List<JanjiPeriksa>> fetchAll(int idUser) async {
    try {
      var response = await get(Uri.http(url, 'api/index/$idUser'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)["data"];

      return list.map((e) => JanjiPeriksa.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<JanjiPeriksa> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return JanjiPeriksa.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(JanjiPeriksa janjiPeriksa) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: janjiPeriksa.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(JanjiPeriksa janjiPeriksa) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${janjiPeriksa.id}'),
        headers: {"Content-Type": "application/json"},
        body: janjiPeriksa.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(int id) async {
    try {
      var response = await delete(Uri.http(url, 'api/destroy/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
