import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class KontakView extends StatefulWidget {
  const KontakView({super.key});

  @override
  State<KontakView> createState() => KontakViewState();
}

class KontakViewState extends State<KontakView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kontak',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: cAccentColor,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Text('kontak rs, kontak emergency, igd'),
          ],
        ),
      ),
    );
  }
}
