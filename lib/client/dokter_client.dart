import 'dart:convert';

import 'package:http/http.dart';
import 'package:ugd_modul_2_kel1/entity/dokter.dart';

class DokterClient {
  // untuk emulator
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/dokter';

  // untuk hp
  // static final String url = '192.168.1.14';
  // static final String endpoint = '/GD_API_1180/public/api/dokter';

  static Future<List<Dokter>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)["data"];

      return list.map((e) => Dokter.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Dokter> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return Dokter.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Dokter dokter) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: dokter.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Dokter dokter) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${dokter.id}'),
        headers: {"Content-Type": "application/json"},
        body: dokter.toRawJson(),
      );

      print(json.decode(response.body)['message']);
      print(json.decode(response.body)['status']);

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // if (file != null) {
      //   var request = MultipartRequest('POST', Uri.parse(url + endpoint));

      //   var fileMultipart = MultipartFile.fromBytes(
      //     'image',
      //     File(file.path).readAsBytesSync(),
      //     filename: file.path,
      //   );

      //   // request.fields['title'] = file.path.toString();
      //   request.files.add(fileMultipart);

      //   var responseImg = await request.send();

      //   if (responseImg.statusCode != 200) {
      //     throw Exception(responseImg.reasonPhrase);
      //   }
      // }

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, "$endpoint/$id"));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
