import 'dart:convert';

import 'package:http/http.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';

class AuthClient {
  // untuk emulator
  static const String url = '10.0.2.2:8000';
  static const String endpointRegister = '/api/register';
  static const String endpointLogin = '/api/login';

  // untuk hp
  // static final String url = '192.168.1.14';
  // static final String endpointRegister = '/GD_API_1180/public/api/register';
  // static final String endpointLogin = '/GD_API_1180/public/api/login';

  // METHODS

  // register
  static Future<Response> register(User user) async {
    try {
      var response = await post(
        Uri.http(url, endpointRegister),
        headers: {"Content-Type": "application/json"},
        body: user.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // login
  static Future<User> login(User user) async {
    User userLoggedIn = User();

    try {
      var response = await post(
        Uri.http(url, endpointLogin),
        headers: {"Content-Type": "application/json"},
        body: user.toRawJson(),
      );

      print(json.decode(response.body)['message']);

      // if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      if (response.statusCode == 200) {
        userLoggedIn = User.fromJson(json.decode(response.body)['data']);
      }

      // print(userLoggedIn!.username);
    } catch (e) {
      print(Future.error(e.toString()));
    }

    return userLoggedIn;
  }
}