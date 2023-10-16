import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/View/input_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/View/grid.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                const Text('Rumah Sakit'),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CreateJanjiPeriksaView(
                                    janjiPeriksa: null,
                                  )));
                    },
                    child: const Text('Buat Janji Periksa'),
                  ),
                ),
                const MyGrid(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
