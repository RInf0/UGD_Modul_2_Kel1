import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_modul_2_kel1/testing/auth_testing.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';

void main() {
  test('login success', () async {
    final hasil = await AuthTesting.loginTesting(
      user: User(username: 'a', password: 'aaaaa'),
    );
    expect(hasil?.data.username, equals('a'));
    expect(hasil?.data.password, equals('aaaaa'));
  });

  test('login failed', () async {
    final result = await AuthTesting.loginTesting(
      user: User(username: 'invalid', password: 'invalid'),
    );
    expect(result, null);
  });
}
