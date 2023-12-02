import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:ugd_modul_2_kel1/document_scanner/cunning_scanner.dart';
// import 'package:ugd_modul_2_kel1/document_scanner/document_scanner_flutter.dart';
// import 'package:ugd_modul_2_kel1/document_scanner/edge_detection_scanner.dart';
// import 'package:ugd_modul_2_kel1/speech_to_text/google_speech.dart';
// import 'package:ugd_modul_2_kel1/speech_to_text/speech_to_text_page.dart';
// import 'package:ugd_modul_2_kel1/speech_to_text/speech_to_text_widget.dart';
import 'package:ugd_modul_2_kel1/view/login/login.dart';

// RUN APP
void main() {
  // RUN MYAPP
  runApp(
    ProviderScope(
      child: MyApp(
        key: myAppKey,
      ),
    ),
  );

  // TEST CUNNING DOCUMENT SCANNER
  // runApp(const CDocScanner());

  // TEST EDGE DETECTION SCANNER
  // runApp(EdgeDetectionScanner());

  // TEST DOCUMENT SCANNER FLUTTER
  // runApp(DocScannerFlutter());

  // TEST SPEECH TO TEXT
  // runApp(const KeluhanSpeechToTextPage());
  // runApp(GoogleSpeechPage());
}

// global key untuk class MyApp
final myAppKey = MyApp.createKey();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  // membuat global key untuk simpan state dari MyAppState
  static GlobalKey<MyAppState> createKey() => GlobalKey<MyAppState>();
}

class MyAppState extends State<MyApp> {
  // variabel dark/light(system) theme, init awal
  ThemeMode _themeMode = ThemeMode.light;
  Icon _changeThemeButtonIcon = const Icon(Icons.light_mode);
  bool _isDarkTheme = false;

  // get is dark theme
  bool getIsDarkTheme() {
    return _isDarkTheme;
  }

  // get icon theme
  Icon getThemeButtonIcon() {
    return _changeThemeButtonIcon;
  }

  // method untuk mengubah theme
  void changeTheme(bool isDarkTheme) {
    setState(() {
      if (!isDarkTheme) {
        _themeMode = ThemeMode.dark;
        _isDarkTheme = true;
        _changeThemeButtonIcon = const Icon(Icons.dark_mode);
      } else {
        _themeMode = ThemeMode.light;
        _isDarkTheme = false;
        _changeThemeButtonIcon = const Icon(Icons.light_mode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      Device.orientation == Orientation.portrait
          ? Container(
              width: 100.w,
              height: 20.5.h,
            )
          : Container(
              width: 100.w,
              height: 12.5.h,
            );
      Device.screenType == ScreenType.tablet
          ? Container(
              width: 100.w,
              height: 20.5.h,
            )
          : Container(
              width: 100.w,
              height: 12.5.h,
            );
      return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.green.shade800,
          ),
        ),
        themeMode: _themeMode,
        home: LoginView(),
      );
    });
  }
}

// OLD MAINAPP
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.green,
//         ),
//       ),
//       darkTheme: ThemeData.dark(useMaterial3: true),
//       themeMode: _themeMode,
//       home: const LoginView(),
//     );
//   }
// }
