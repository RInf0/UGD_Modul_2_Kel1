import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ugd_modul_2_kel1/main.dart' as app;
import 'package:ugd_modul_2_kel1/view/daftar_periksa/daftar_periksa.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/input_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/view/home/home.dart';
import 'package:ugd_modul_2_kel1/view/home/main_home.dart';
import 'package:ugd_modul_2_kel1/view/login/login.dart';
import 'package:ugd_modul_2_kel1/view/register/register.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const duration = Duration(milliseconds: 900);

  // INTEGRATION TESTING

  group('Integration Testing REGISTER:', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    // TEST REGISTER BERHASIL
    testWidgets('Register Success', (WidgetTester tester) async {
      FlutterError.onError = (FlutterErrorDetails details) {
        bool ifIsOverflowError = false;

        // Detect overflow error.
        var exception = details.exception;
        if (exception is FlutterError) {
          ifIsOverflowError = !exception.diagnostics.any((e) =>
              e.value.toString().startsWith("A RenderFlex overflowed by"));
        }

        // Ignore if it's an overflow error.
        if (ifIsOverflowError) {
          // ignore: avoid_print
          print('Overflow error.');
        } else {
          // Throw other errors.
          FlutterError.dumpErrorToConsole(details);
        }
      };

      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      app.main();
      await tester.pumpAndSettle();

      expect(find.byType(LoginView), findsOneWidget);

      // dari login view, arahkan ke register view
      final buttonRegisterHere = find.byKey(const Key('button_register_here'));
      await tester.tap(buttonRegisterHere);

      await tester.pumpAndSettle();

      expect(find.byType(RegisterView), findsOneWidget);

      // find 5 textformfield lalu isi masing masingnya
      expect(find.byType(TextFormField), findsAtLeastNWidgets(5));

      expect(find.byKey(const Key('usernameTest')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('usernameTest')), 'user1');
      await tester.pump(duration);

      expect(find.byKey(const Key('emailTest')), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key('emailTest')), 'user1@gmail.com');
      await tester.pump(duration);

      expect(find.byKey(const Key('passwordTest')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('passwordTest')), '12345');
      await tester.pump(duration);

      expect(find.byKey(const Key('tglLahirTest')), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key('tglLahirTest')), '16-04-2003');
      await tester.pump(duration);

      expect(find.byKey(const Key('noTelpTest')), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key('noTelpTest')), '081372816372');
      await tester.pump(duration);

      // find and tap radio button jenis kelamin
      await tester.ensureVisible(find.byKey(const Key('genderMaleTest')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('genderMaleTest')), findsOneWidget);
      await tester.tap(find.byKey(const Key('genderMaleTest')));
      await tester.pumpAndSettle();

      // find and tap checkbox BPJS
      expect(find.byType(CheckboxListTile), findsAtLeastNWidgets(1));
      final checkboxListTileHasBPJS = find.byType(CheckboxListTile);
      await tester.tap(checkboxListTileHasBPJS);
      await tester.pumpAndSettle();

      // find and tap button register
      await tester.ensureVisible(find.byKey(const Key('registerClick')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('registerClick')), findsOneWidget);
      await tester.tap(find.byKey(const Key('registerClick')));
      await tester.pumpAndSettle();

      await tester.pump(duration);

      // find and tap yes untuk register
      expect(find.byKey(const Key('yesButton')), findsOneWidget);
      await tester.tap(find.byKey(const Key('yesButton')));
      await tester.pumpAndSettle();

      expect(
          find.byKey(const Key('snackbar_register_berhasil')), findsOneWidget);

      await tester.pump(duration);
    });

    // TEST REGISTER GAGAL
    testWidgets('Register Failed', (WidgetTester tester) async {
      FlutterError.onError = (FlutterErrorDetails details) {
        bool ifIsOverflowError = false;

        // Detect overflow error.
        var exception = details.exception;
        if (exception is FlutterError) {
          ifIsOverflowError = !exception.diagnostics.any((e) =>
              e.value.toString().startsWith("A RenderFlex overflowed by"));
        }

        // Ignore if it's an overflow error.
        if (ifIsOverflowError) {
          // ignore: avoid_print
          print('Overflow error.');
        } else {
          // Throw other errors.
          FlutterError.dumpErrorToConsole(details);
        }
      };

      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      app.main();
      await tester.pumpAndSettle();

      expect(find.byType(LoginView), findsOneWidget);

      // dari login view, arahkan ke register view
      final buttonRegisterHere = find.byKey(const Key('button_register_here'));
      await tester.tap(buttonRegisterHere);

      await tester.pumpAndSettle();

      expect(find.byType(RegisterView), findsOneWidget);

      // find 5 textformfield lalu isi masing masingnya
      expect(find.byType(TextFormField), findsAtLeastNWidgets(5));

      expect(find.byKey(const Key('usernameTest')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('usernameTest')), 'user1');
      await tester.pump(duration);

      // error disini karena harus @
      expect(find.byKey(const Key('emailTest')), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key('emailTest')), 'user1*gmail.com');
      await tester.pump(duration);

      // error karena password hanya 3 karakter
      expect(find.byKey(const Key('passwordTest')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('passwordTest')), '123');
      await tester.pump(duration);

      expect(find.byKey(const Key('tglLahirTest')), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key('tglLahirTest')), '16-04-2003');
      await tester.pump(duration);

      expect(find.byKey(const Key('noTelpTest')), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key('noTelpTest')), '081372816372');
      await tester.pump(duration);

      // find and tap radio button jenis kelamin
      await tester.ensureVisible(find.byKey(const Key('genderMaleTest')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('genderMaleTest')), findsOneWidget);
      await tester.tap(find.byKey(const Key('genderMaleTest')));
      await tester.pumpAndSettle();

      // find and tap checkbox BPJS
      expect(find.byType(CheckboxListTile), findsAtLeastNWidgets(1));
      final checkboxListTileHasBPJS = find.byType(CheckboxListTile);
      await tester.tap(checkboxListTileHasBPJS);
      await tester.pumpAndSettle();

      // find and tap button register
      await tester.ensureVisible(find.byKey(const Key('registerClick')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('registerClick')), findsOneWidget);
      await tester.tap(find.byKey(const Key('registerClick')));
      await tester.pumpAndSettle();

      await tester.pump(duration);

      // expect validasi
      expect(find.text('Email harus menggunakan @'), findsOneWidget);
      expect(find.text('Password minimal 5 karakter'), findsOneWidget);

      await tester.pump(duration);
    });
  });

  group('Integration Testing LOGIN:', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  group('Integration Testing JANJI PERIKSA CRUD:', () {
    // hanya dipanggil utuk test CRUD
    Future<void> isiLoginUntukCRUD(WidgetTester tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      const durationLogin = Duration(milliseconds: 400);

      app.main();
      await tester.pumpAndSettle();

      const username = 'a';
      const password = 'aaaaa';

      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));

      final textField = find.byType(TextFormField);
      await tester.enterText(textField.at(0), username);
      await tester.pump(durationLogin);

      await tester.enterText(textField.at(1), password);
      await tester.pump(durationLogin);

      expect(find.byType(ElevatedButton), findsWidgets);
      final loginButton = find.byKey(const Key('button_login'));

      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
      await tester.pump(durationLogin);
    }

    // TEST CREATE

    testWidgets('Create', (WidgetTester tester) async {
      await isiLoginUntukCRUD(tester);

      expect(find.byType(MainHomeView), findsOneWidget);

      // masuk ke buat janji page
      expect(
          find.byKey(const Key('button_buat_janji_periksa')), findsOneWidget);

      final btnBuatJanji = find.byKey(const Key('button_buat_janji_periksa'));
      await tester.tap(btnBuatJanji);
      await tester.pumpAndSettle();
      await tester.pump(duration);

      // expect view create janji periksa
      expect(find.byType(CreateJanjiPeriksaView), findsOneWidget);

      // expect dropdown nama dokter
      expect(find.byKey(const Key('dropdown_dokter')), findsOneWidget);
      final dropdown = find.byKey(const Key('dropdown_dokter'));
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      await tester.pump(duration);

      // khusus DropdownMenuEntry perlu pakai .last
      // source https://stackoverflow.com/questions/69012695/flutter-how-to-select-dropdownbutton-item-in-widget-test

      expect(find.text('dr. Willy').last, findsOneWidget);
      final dropdownItem = find.text('dr. Willy').last;
      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();
      await tester.pump(duration);

      // expect textfields
      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
      final textField = find.byType(TextFormField);

      // tap textfield tanggal periksa
      await tester.tap(textField.at(0));
      await tester.pumpAndSettle();
      await tester.pump(duration);

      expect(find.text('OK'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.pump(duration);

      // entertext textfield keluhan
      await tester.tap(textField.at(1));
      await tester.enterText(textField.at(1), 'sakit maag dan asam lambung');
      await tester.pumpAndSettle();
      await tester.pump(duration);

      // submit
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Submit'));

      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
      final btnSubmit = find.widgetWithText(ElevatedButton, 'Submit');
      await tester.tap(btnSubmit);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('snackbar_create_janji_berhasil')),
          findsOneWidget);

      await tester.pump(duration);
    });

    // TEST READ
    testWidgets('Read', (WidgetTester tester) async {
      await isiLoginUntukCRUD(tester);
      expect(find.byType(MainHomeView), findsOneWidget);

      expect(find.byKey(const Key('bottom_navbar_daftar_periksa')),
          findsOneWidget);

      // tap bottom navbar daftar periksa untuk menuju tampilan daftar periksa
      final navHome = find.byKey(const Key('bottom_navbar_daftar_periksa'));
      await tester.tap(navHome);
      await tester.pumpAndSettle();
      await tester.pump(duration);

      expect(find.byType(DaftarPeriksaView), findsOneWidget);
      await tester.pump(duration);
    });

    testWidgets('Update', (WidgetTester tester) async {
      await isiLoginUntukCRUD(tester);
    });

    testWidgets('Delete', (WidgetTester tester) async {
      await isiLoginUntukCRUD(tester);
    });
  });
}

// CODE LAMA
// testWidgets('Register Failed', (WidgetTester tester) async {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   app.main();
//   await tester.pumpAndSettle();

//   FlutterError.onError = (FlutterErrorDetails details) {
//     bool ifIsOverflowError = false;
//     // Detect overflow error.
//     var exception = details.exception;
//     if (exception is FlutterError) {
//       ifIsOverflowError = !exception.diagnostics.any((e) =>
//           e.value.toString().startsWith("A RenderFlex overflowed by"));
//     }

//     // Ignore if it's an overflow error.
//     if (ifIsOverflowError) {
//       print('Overflow error.');
//     } else {
//       // Throw other errors.
//       FlutterError.dumpErrorToConsole(details);
//     }
//   };

//   await tester.pumpWidget(const MaterialApp(home: RegisterView()));
//   await tester.enterText(find.byKey(const Key('usernameTest')), 'user1');
//   await tester.enterText(find.byKey(const Key('emailTest')),
//       'user1*gmail.com'); // error disini karena harus @
//   await tester.enterText(find.byKey(const Key('passwordTest')), '123456');
//   await tester.enterText(
//       find.byKey(const Key('tglLahirTest')), '16/04/2003');
//   await tester.enterText(
//       find.byKey(const Key('noTelpTest')), '561327389023');
//   await tester.tap(find.byKey(const Key('genderMaleTest')));

//   await tester.ensureVisible(find.byKey(const Key('registerClick')));
//   await tester.pumpAndSettle(const Duration(seconds: 1));
//   await tester.tap(find.byKey(const Key('registerClick')));

//   await tester.pumpAndSettle(const Duration(seconds: 1));
//   await tester.tap(find.byKey(const Key('yesButton')));

//   await tester.pumpAndSettle();
// });

// TEST REGISTER BERHASIL BY SETO
// testWidgets('Register Berhasil', (WidgetTester tester) async {
//   // data register
//   const username = 'helloworld';
//   const email = 'helloworld@gmail.com';
//   const password = 'helloworld123';
//   const tglLahir = '04-11-2007';
//   const noTelp = '081283728132';
//   const jenisKelamin = 'L';
//   const hasBPJS = true;

//   app.main();
//   await tester.pumpAndSettle();

//   expect(find.byType(LoginView), findsOneWidget);

//   final buttonRegisterHere = find.byKey(const Key('button_register_here'));
//   await tester.tap(buttonRegisterHere);

//   await tester.pumpAndSettle();

//   expect(find.byType(RegisterView), findsOneWidget);

//   expect(find.byType(TextFormField), findsAtLeastNWidgets(5));

//   final textField = find.byType(TextFormField);

//   await tester.enterText(textField.at(0), username);
//   await tester.pump(duration);

//   await tester.enterText(textField.at(1), email);
//   await tester.pump(duration);

//   await tester.enterText(textField.at(2), password);
//   await tester.pump(duration);

//   // tgl lahir
//   // await tester.enterText(textField.at(3), tglLahir);
//   // await tester.pump(duration);

//   await tester.enterText(textField.at(4), noTelp);
//   await tester.pump(duration);

//   expect(find.byType(RadioListTile), findsAtLeastNWidgets(2));
//   final radioListTileJenisKelamin = find.byType(RadioListTile);

//   if (jenisKelamin == 'L') {
//     await tester.tap(radioListTileJenisKelamin.at(0));
//   } else {
//     await tester.tap(radioListTileJenisKelamin.at(1));
//   }

//   expect(find.byType(CheckboxListTile), findsAtLeastNWidgets(1));
//   final checkboxListTileHasBPJS = find.byType(CheckboxListTile);

//   if (hasBPJS) {
//     await tester.tap(checkboxListTileHasBPJS);
//   }

//   expect(find.byKey(const Key('button_register')), findsOneWidget);
//   final registerButton = find.byKey(const Key('button_register'));

//   await tester.tap(registerButton);

//   await tester.pumpAndSettle();

//   await tester.pump(duration);
// });
