import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/View/pesan_kamar/input_pesan_kamar.dart';
import 'package:ugd_modul_2_kel1/client/pesan_kamar_client.dart';
import 'package:ugd_modul_2_kel1/client/user_client.dart';
import 'package:ugd_modul_2_kel1/entity/pesan_kamar.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class DaftarPesanKamarView extends StatefulWidget {
  const DaftarPesanKamarView({super.key});

  @override
  State<DaftarPesanKamarView> createState() => _DaftarPesanKamarViewState();
}

class _DaftarPesanKamarViewState extends State<DaftarPesanKamarView> {
  // List<Map<String, dynamic>> listPesanKamar = [];
  List<PesanKamar> listPesanKamar = [];
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

    // final dataKamar = await SQLHelperPesanKamar.getPesanKamarById(idPasien);
    final dataKamar = await PesanKamarClient.fetchAll(idPasien);

    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      listPesanKamar = dataKamar;
      isLoadingData = false;
    });
  }

  Future<void> deletePesanKamar(int id) async {
    // await SQLHelperPesanKamar.deletePesanKamar(id);
    await PesanKamarClient.destroy(id);
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
                  'Daftar Pesanan Kamar',
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

    if (listPesanKamar.isEmpty) {
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
                  'Daftar Pesanan Kamar',
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
            child: Text('Kamar Masih Kosong!'),
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
                'Daftar Pesanan Kamar',
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
          itemCount: listPesanKamar.length,
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
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                    //   decoration: const BoxDecoration(
                    //     color: Color.fromARGB(255, 243, 243, 243),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             listPesanKamar[index].tglPesan,
                    //             style: cTextStyle3,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              width: 150,
                              child: Image.asset(
                                'image/rumahsakit-squared.png',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 5,
                              right: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listPesanKamar[index].tglPesan,
                                  style: cTextStyle3,
                                ),
                                Text('Kelas: ${listPesanKamar[index].kelas}'),
                                Text(
                                  'Spesialisasi: ${listPesanKamar[index].spesialisasi}',
                                ),
                                Text('Usia: ${listPesanKamar[index].usia}'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: cAccentColor,
                          //     foregroundColor: Colors.white,
                          //   ),
                          //   onPressed: () async {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (_) =>
                          //         DetailPesanKamarView(
                          //           pesanKamar: PesanKamar(
                          //             id: listPesanKamar[index].id,
                          //             namaDokter:
                          //                 listPesanKamar[index].namaDokter,
                          //             tglPeriksa:
                          //                 listPesanKamar[index].tglPeriksa,
                          //             keluhan: listPesanKamar[index].keluhan,
                          //           ),
                          //           userPassed: userProfile,
                          //         ),
                          //       ),
                          //     ).then(
                          //       (_) => refresh(),
                          //     );
                          //   },
                          //   child: const Text('Detail'),
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: cAccentColor,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreatePesanKamarView(
                                    pesanKamar: listPesanKamar[index],
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
                              await deletePesanKamar(listPesanKamar[index].id!);

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  key: Key('snackbar_delete_kamar_berhasil'),
                                  content: Text('Berhasil Delete Kamar'),
                                ),
                              );
                            },
                            child: const Icon(FontAwesomeIcons.trashCan),
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
