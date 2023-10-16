import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/View/input_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';

class DaftarPeriksaView extends StatefulWidget {
  const DaftarPeriksaView({super.key});

  @override
  State<DaftarPeriksaView> createState() => _DaftarPeriksaViewState();
}

class _DaftarPeriksaViewState extends State<DaftarPeriksaView> {
  List<Map<String, dynamic>> listJanjiPeriksa = [];
  List<Map<String, dynamic>> userProfile = [];

  void refresh() async {
    final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');

    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    final userData =
        data.where((user) => user['username'] == storedUsername).toList();

    setState(() {
      userProfile = userData;
    });

    int idPasien = userProfile[0]['id'];

    final dataJanji = await SQLHelperJanjiPeriksa.getJanjiPeriksaById(idPasien);
    setState(() {
      listJanjiPeriksa = dataJanji;
    });
  }

  Future<void> deleteJanjiPeriksa(int id) async {
    await SQLHelperJanjiPeriksa.deleteJanjiPeriksa(id);
    refresh();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listJanjiPeriksa.isEmpty) {
      return const Center(
        child: Text('Janji Periksa Masih Kosong!'),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: listJanjiPeriksa.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green.shade300,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              'image/${listJanjiPeriksa[index]['nama_dokter'].toLowerCase()}.jpg',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listJanjiPeriksa[index]['id_pasien']
                                  .toString()),
                              Text(listJanjiPeriksa[index]['tgl_periksa']),
                              Text(listJanjiPeriksa[index]['nama_dokter']),
                              Text(listJanjiPeriksa[index]['keluhan']),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreateJanjiPeriksaView(
                                    janjiPeriksa: JanjiPeriksa(
                                      id: listJanjiPeriksa[index]['id'],
                                      idPasien: listJanjiPeriksa[index]
                                          ['id_pasien'],
                                      namaDokter: listJanjiPeriksa[index]
                                          ['nama_dokter'],
                                      tglPeriksa: listJanjiPeriksa[index]
                                          ['tgl_periksa'],
                                      keluhan: listJanjiPeriksa[index]
                                          ['keluhan'],
                                    ),
                                  ),
                                ),
                              ).then(
                                (_) => refresh(),
                              );
                            },
                            child: const Text('Update'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await deleteJanjiPeriksa(
                                  listJanjiPeriksa[index]['id']);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
