import 'dart:convert';

import 'package:http/http.dart';
import 'package:ugd_modul_2_kel1/entity/pesan_kamar.dart';

class PesanKamarClient {
  // untuk emulator
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/pesankamar';

  // untuk hp
  // static final String url = '192.168.1.14';
  // static final String endpoint = '/GD_API_1180/public/api/User';

  static Future<List<PesanKamar>> fetchAll(int idUser) async {
    try {
      var response = await get(Uri.http(url, ''));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)["data"];

      return list.map((e) => PesanKamar.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<PesanKamar> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return PesanKamar.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(PesanKamar pesanKamar) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: pesanKamar.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(PesanKamar pesanKamar) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${pesanKamar.id}'),
        headers: {"Content-Type": "application/json"},
        body: pesanKamar.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(int id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  } 
}