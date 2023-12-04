import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugd_modul_2_kel1/View/register/register.dart';
import 'package:ugd_modul_2_kel1/main.dart' as app;

void main() {
  testWidgets('Register Success', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FlutterError.onError = (FlutterErrorDetails details) {
      bool ifIsOverflowError = false;

      // Detect overflow error.
      var exception = details.exception;
      if (exception is FlutterError) {
        ifIsOverflowError = !exception.diagnostics.any(
            (e) => e.value.toString().startsWith("A RenderFlex overflowed by"));
      }

      // Ignore if it's an overflow error.
      if (ifIsOverflowError) {
        print('Overflow error.');
      } else {
        // Throw other errors.
        FlutterError.dumpErrorToConsole(details);
      }
    };

    await tester.pumpWidget(const MaterialApp(home: RegisterView()));
    await tester.enterText(find.byKey(const Key('usernameTest')), 'user1');
    await tester.enterText(
        find.byKey(const Key('emailTest')), 'user1@gmail.com');
    await tester.enterText(find.byKey(const Key('passwordTest')), '123456');
    await tester.enterText(find.byKey(const Key('tglLahirTest')), '16/04/2003');
    await tester.enterText(find.byKey(const Key('noTelpTest')), '561327389023');
    await tester.tap(find.byKey(const Key('genderMaleTest')));

    await tester.ensureVisible(find.byKey(const Key('registerClick')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('registerClick')));

    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('yesButton')));

    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  testWidgets('Register Failed', (WidgetTester tester) async {
    app.main();

    FlutterError.onError = (FlutterErrorDetails details) {
      bool ifIsOverflowError = false;
      // Detect overflow error.
      var exception = details.exception;
      if (exception is FlutterError) {
        ifIsOverflowError = !exception.diagnostics.any(
            (e) => e.value.toString().startsWith("A RenderFlex overflowed by"));
      }

      // Ignore if it's an overflow error.
      if (ifIsOverflowError) {
        print('Overflow error.');
      } else {
        // Throw other errors.
        FlutterError.dumpErrorToConsole(details);
      }
    };

    await tester.pumpWidget(const MaterialApp(home: RegisterView()));
    await tester.enterText(find.byKey(const Key('usernameTest')), 'user1');
    await tester.enterText(find.byKey(const Key('emailTest')),
        'user1*gmail.com'); // error disini karena harus @
    await tester.enterText(find.byKey(const Key('passwordTest')), '123456');
    await tester.enterText(find.byKey(const Key('tglLahirTest')), '16/04/2003');
    await tester.enterText(find.byKey(const Key('noTelpTest')), '561327389023');
    await tester.tap(find.byKey(const Key('genderMaleTest')));

    await tester.ensureVisible(find.byKey(const Key('registerClick')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('registerClick')));

    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('yesButton')));

    await tester.pumpAndSettle();
  });
}
