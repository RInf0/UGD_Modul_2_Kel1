import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/client/janji_periksa_client.dart';
import 'package:ugd_modul_2_kel1/client/user_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/detail_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/input_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';

class DaftarPeriksaView extends StatefulWidget {
  const DaftarPeriksaView({super.key});

  @override
  State<DaftarPeriksaView> createState() => _DaftarPeriksaViewState();
}

class _DaftarPeriksaViewState extends State<DaftarPeriksaView> {
  // List<Map<String, dynamic>> listJanjiPeriksa = [];
  List<JanjiPeriksa> listJanjiPeriksa = [];
  User? userProfile;

  bool isLoadingData = true;

  void refresh() async {
    // final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getInt('id');

    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    // final userData =
    //     data.where((user) => user['username'] == storedUsername).toList();

    final userData = await UserClient.find(storedId);

    setState(() {
      userProfile = userData;
    });

    int idPasien = storedId!;

    // final dataJanji = await SQLHelperJanjiPeriksa.getJanjiPeriksaById(idPasien);
    final dataJanji = await JanjiPeriksaClient.fetchAll(idPasien);

    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      listJanjiPeriksa = dataJanji;
      isLoadingData = false;
    });
  }

  Future<void> deleteJanjiPeriksa(int id) async {
    // await SQLHelperJanjiPeriksa.deleteJanjiPeriksa(id);
    await JanjiPeriksaClient.destroy(id);
    refresh();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
                              'image/${listJanjiPeriksa[index].namaDokter.toLowerCase()}.jpg',
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
                              Text(listJanjiPeriksa[index].idPasien.toString()),
                              Text(listJanjiPeriksa[index].tglPeriksa),
                              Text(listJanjiPeriksa[index].namaDokter),
                              Text(listJanjiPeriksa[index].keluhan),
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
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailJanjiPeriksaView(
                                    janjiPeriksaPassed: JanjiPeriksa(
                                      id: listJanjiPeriksa[index].id,
                                      namaDokter:
                                          listJanjiPeriksa[index].namaDokter,
                                      tglPeriksa:
                                          listJanjiPeriksa[index].tglPeriksa,
                                      keluhan: listJanjiPeriksa[index].keluhan,
                                    ),
                                    userPassed: userProfile,
                                  ),
                                ),
                              ).then(
                                (_) => refresh(),
                              );
                            },
                            child: const Text('Detail'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreateJanjiPeriksaView(
                                    janjiPeriksa: listJanjiPeriksa[index],
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
                                  listJanjiPeriksa[index].id!);

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  key: Key(
                                      'snackbar_delete_janji_periksa_berhasil'),
                                  content:
                                      Text('Berhasil Delete Janji Periksa'),
                                ),
                              );
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
