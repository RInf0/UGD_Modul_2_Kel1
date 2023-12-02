import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ugd_modul_2_kel1/main.dart' as app;
import 'package:ugd_modul_2_kel1/view/home/home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const duration = Duration(milliseconds: 900);

  // INTEGRATION TESTING
  group('Integration Testing:', () {
    // TEST LOGIN BERHASIL
    testWidgets('Login Berhasil', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      const username = 'a';
      const password = 'aaaaa';

      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));

      final textField = find.byType(TextFormField);
      await tester.enterText(textField.at(0), username);
      await tester.pump(duration);

      await tester.enterText(textField.at(1), password);
      await tester.pump(duration);

      expect(find.byType(ElevatedButton), findsWidgets);
      final loginButton = find.byKey(const Key('button_login'));

      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
      await tester.pump(duration);
    });

    // TEST LOGIN GAGAL
    testWidgets('Login Gagal', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      const username = 'loginsalah';
      const password = 'loginsalah';

      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));

      final textField = find.byType(TextFormField);
      await tester.enterText(textField.at(0), username);
      await tester.pump(duration);

      await tester.enterText(textField.at(1), password);
      await tester.pump(duration);

      expect(find.byType(ElevatedButton), findsWidgets);
      final loginButton = find.byKey(const Key('button_login'));

      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      expect(
        find.widgetWithText(AlertDialog, 'Username atau password salah!'),
        findsOneWidget,
      );
      await tester.pump(duration);
    });
  });
}
