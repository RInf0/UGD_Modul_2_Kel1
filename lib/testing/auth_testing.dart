import 'package:http/http.dart' as http;
import 'package:ugd_modul_2_kel1/entity/user.dart';

class AuthTesting {
  // untuk emulator
  static const String url = '10.0.2.2:8000';
  static const String endpointRegister = '/api/register';
  static const String endpointLogin = '/api/login';
  static const String endpointResetPassword = '/api/resetPassword';

  static http.Client client = http.Client();

  // untuk hp
  // static final String url = '192.168.1.14';
  // static final String endpointRegister = '/GD_API_1180/public/api/register';
  // static final String endpointLogin = '/GD_API_1180/public/api/login';

  // METHODS

  // login testing
  static Future<LoginModel?> loginTesting({
    required User user,
  }) async {
    String apiURL = 'http://127.0.0.1:8000/api/login';

    try {
      var apiResult = await http.post(
        Uri.parse(apiURL),
        body: user.toRawJson(),
      );

      if (apiResult.statusCode == 200) {
        final result = LoginModel.fromRawJson(apiResult.body);
        return result;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      return null;
    }
  }

  // register testing
  static Future<LoginModel?> registerTesting({
    required User user,
  }) async {
    String apiURL = 'http://127.0.0.1:8000/api/register';

    try {
      var apiResult = await http.post(
        Uri.parse(apiURL),
        body: user.toRawJson(),
      );

      if (apiResult.statusCode == 200) {
        final result = LoginModel.fromRawJson(apiResult.body);
        return result;
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      return null;
    }
  }
}
