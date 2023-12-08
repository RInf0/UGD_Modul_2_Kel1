import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class TentangKamiView extends StatefulWidget {
  const TentangKamiView({super.key});

  @override
  State<TentangKamiView> createState() => TentangKamiViewState();
}

class TentangKamiViewState extends State<TentangKamiView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Kami',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: cAccentColor,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Text('blablabla, sejarah ngarang, pendiri alamat, foto gedung rs'),
          ],
        ),
      ),
    );
  }
}
