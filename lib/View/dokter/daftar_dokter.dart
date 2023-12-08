import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/View/dokter/input_dokter.dart';
import 'package:ugd_modul_2_kel1/client/dokter_client.dart';
import 'package:ugd_modul_2_kel1/client/user_client.dart';
import 'package:ugd_modul_2_kel1/entity/dokter.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class DaftarDokterView extends StatefulWidget {
  const DaftarDokterView({super.key, this.isUserAdmin = false});

  final bool isUserAdmin;

  @override
  State<DaftarDokterView> createState() => _DaftarDokterViewState();
}

class _DaftarDokterViewState extends State<DaftarDokterView> {
  // List<Map<String, dynamic>> listDokter = [];
  List<Dokter> listDokter = [];
  User? userProfile;

  bool isLoadingData = true;

  bool isAdmin = false;

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

    // final dataDokter = await SQLHelperDokter.getDokterById(idPasien);
    final dataDokter = await DokterClient.fetchAll();

    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      listDokter = dataDokter;
      isLoadingData = false;
    });
  }

  Future<void> deleteDokter(int id) async {
    // await SQLHelperDokter.deleteDokter(id);
    await DokterClient.destroy(id);
    refresh();
  }

  @override
  void initState() {
    refresh();
    isAdmin = widget.isUserAdmin;
    super.initState();
  }

  Widget buttonAdmin(Dokter dokter) {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: cAccentColor,
            backgroundColor: Colors.white,
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InputDokterView(
                  dokter: dokter,
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
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.redAccent,
            backgroundColor: Colors.white,
          ),
          onPressed: () async {
            await deleteDokter(dokter.id!);

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Berhasil Delete Dokter'),
              ),
            );
          },
          child: const Icon(FontAwesomeIcons.trashCan),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingData) {
      return Scaffold(
        floatingActionButton: !isAdmin
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InputDokterView()),
                  ).then(
                    (_) => refresh(),
                  );
                },
                child: const FaIcon(FontAwesomeIcons.plus),
              ),
        appBar: AppBar(
          backgroundColor: cAccentColor,
          title: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daftar Dokter',
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

    if (listDokter.isEmpty) {
      return Scaffold(
        floatingActionButton: !isAdmin
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InputDokterView()),
                  ).then(
                    (_) => refresh(),
                  );
                },
                child: const FaIcon(FontAwesomeIcons.plus),
              ),
        appBar: AppBar(
          backgroundColor: cAccentColor,
          title: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daftar Dokter',
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
            child: Text('Data Dokter Masih Kosong!'),
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: !isAdmin
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InputDokterView()),
                ).then(
                  (_) => refresh(),
                );
              },
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
      appBar: AppBar(
        backgroundColor: cAccentColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Daftar Dokter',
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
          itemCount: listDokter.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
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
                                // 'image/${listDokter[index].nama!.toLowerCase()}.jpg',
                                'image/dokter/${Random().nextInt(3)}.jpg',
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
                                listDokter[index].nama!,
                                style: cTextStyle2,
                              ),
                              Text(
                                listDokter[index].job!,
                              ),
                              Text(
                                listDokter[index].noTelp!,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0, top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 28.sp,
                            width: 35.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: cAccentColor,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) =>
                                //     DetailDokterView(
                                //       DokterPassed: JanjiPeriksa(
                                //         id: listJanjiPeriksa[index].id,
                                //         namaDokter:
                                //             listJanjiPeriksa[index].namaDokter,
                                //         tglPeriksa:
                                //             listJanjiPeriksa[index].tglPeriksa,
                                //         keluhan: listJanjiPeriksa[index].keluhan,
                                //       ),
                                //       userPassed: userProfile,
                                //     ),
                                //   ),
                                // ).then(
                                //   (_) => refresh(),
                                // );
                              },
                              child: const Text('Lihat Profil'),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          if (!isAdmin)
                            SizedBox(
                              height: 28.sp,
                              width: 35.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cAccentColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () async {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) =>
                                  //     DetailDokterView(
                                  //       DokterPassed: JanjiPeriksa(
                                  //         id: listJanjiPeriksa[index].id,
                                  //         namaDokter:
                                  //             listJanjiPeriksa[index].namaDokter,
                                  //         tglPeriksa:
                                  //             listJanjiPeriksa[index].tglPeriksa,
                                  //         keluhan: listJanjiPeriksa[index].keluhan,
                                  //       ),
                                  //       userPassed: userProfile,
                                  //     ),
                                  //   ),
                                  // ).then(
                                  //   (_) => refresh(),
                                  // );
                                },
                                child: const Text('Buat Janji'),
                              ),
                            ),
                          if (isAdmin) buttonAdmin(listDokter[index])
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
