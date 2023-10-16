import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/View/home.dart';
import 'package:ugd_modul_2_kel1/View/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const LoginView(),
      // home: const HomeView(),
    );
  }
}
