import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/client/janji_periksa_client.dart';
import 'package:ugd_modul_2_kel1/client/user_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
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
      return Scaffold(
        backgroundColor: const Color.fromARGB(23, 205, 205, 205),
        appBar: AppBar(
          backgroundColor: cAccentColor,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daftar Jadwal Periksa',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
        body: const SafeArea(
          child: Center(
            child: SpinKitThreeBounce(
              size: 40,
              color: cAccentColor,
            ),
          ),
        ),
      );
    }

    if (listJanjiPeriksa.isEmpty) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(23, 205, 205, 205),
        appBar: AppBar(
          backgroundColor: cAccentColor,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daftar Jadwal Periksa',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
        body: const SafeArea(
          child: Center(
            child: Text('Janji Periksa Masih Kosong!'),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(23, 205, 205, 205),
      appBar: AppBar(
        backgroundColor: cAccentColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Daftar Jadwal Periksa',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: listJanjiPeriksa.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.green.shade300,
                  //   width: 3,
                  // ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0.0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 243, 243, 243)),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listJanjiPeriksa[index].tglPeriksa,
                                style: cTextStyle3,
                              ),
                              Text(
                                  'Antrian ke-${listJanjiPeriksa[index].id! + 3}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                // 'image/dokter/${Random().nextInt(3)}.jpg',
                                'image/dokter/${listJanjiPeriksa[index].idDokter! % 5}.jpg',
                              ),
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
                              Text(
                                listJanjiPeriksa[index].namaDokter,
                                style: cTextStyle2,
                              ),
                              Text('Gedung AH3 - Umum'),
                              Text(
                                  'ID Periksa: A-${(listJanjiPeriksa[index].id!)}'),
                              Text('Jadwal: 14.00 - 14.30'),
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cAccentColor,
                              foregroundColor: Colors.white,
                            ),
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
                            key: const Key('btnEdit'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: cAccentColor,
                              backgroundColor: Colors.white,
                            ),
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
                            child: const Icon(FontAwesomeIcons.penToSquare),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            key: const Key('btnDelete'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              backgroundColor: Colors.white,
                            ),
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
                            child: Icon(FontAwesomeIcons.trashCan),
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
