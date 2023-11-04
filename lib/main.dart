import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/view/login/login.dart';

void main() {
  runApp(
    MyApp(
      key: myAppKey,
    ),
  );
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
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _themeMode,
      home: const LoginView(),
    );
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
