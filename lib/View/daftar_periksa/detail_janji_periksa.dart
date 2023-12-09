import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ugd_modul_2_kel1/client/janji_periksa_client.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/pdf/pdf_view.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailJanjiPeriksaView extends StatefulWidget {
  const DetailJanjiPeriksaView(
      {super.key, required this.janjiPeriksaPassed, this.userPassed});

  final JanjiPeriksa? janjiPeriksaPassed;
  final User? userPassed;

  @override
  State<DetailJanjiPeriksaView> createState() => _DetailJanjiPeriksaViewState();
}

class _DetailJanjiPeriksaViewState extends State<DetailJanjiPeriksaView> {
  JanjiPeriksa? janjiPeriksa;

  FlutterTts tts = FlutterTts();
  // late double height;

  void textToSpeech(String text) async {
    await tts.setLanguage('id-ID');
    await tts.setVolume(0.8);
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);
    await tts.speak(text);
  }

  Future<void> deleteJanjiPeriksa(int id) async {
    await JanjiPeriksaClient.destroy(id);
    refresh();
  }

  void refresh() async {
    final dataJP = await JanjiPeriksaClient.find(widget.janjiPeriksaPassed!.id);

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      janjiPeriksa = dataJP;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    refresh();
    super.initState();
  }

  Container buttonCreatePDF(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      width: 100.w,
      height: 6.h,
      child: ElevatedButton(
        onPressed: () {
          if (janjiPeriksa == null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Warning'),
                content: const Text(
                  'Please fill in all the :.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return;
          } else {
            createPdf(context, janjiPeriksa!, widget.userPassed!);
            // setState(() {
            //   const uuid = Uuid();
            //   id = uuid.v1();
            // });
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: cAccentColor,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18.sp,
            // height = 15.sp;
          ),
        ),
        child: const Text('Cetak PDF'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cAccentColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Detail Periksa',
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: janjiPeriksa == null
            ? const Center(
                child: SpinKitThreeBounce(
                size: 40,
                color: cAccentColor,
              ))
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SizedBox(
                                width: 200,
                                // height: 120,
                                child: Image.asset(
                                  // 'image/dokter/${Random().nextInt(3)}.jpg',
                                  'image/dokter/${janjiPeriksa!.idDokter! % 5}.jpg',
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 2.h,
                        ),

                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        String textUntukDibaca = """ 
                                    Berikut adalah detail janji periksamu,
                                    Kamu periksa di tanggal ${janjiPeriksa!.tglPeriksa},
                                    Dokter pemeriksamu adalah ${janjiPeriksa!.namaDokter},
                                    Keluhanmu adalah ${janjiPeriksa!.keluhan},
                                    Jangan lupa untuk membawa dokumen yang diperlukan.
                                    Terima kasih, semoga lekas sembuh.
                                    """;
                                        textToSpeech(textUntukDibaca);
                                      },
                                      child: Container(
                                        // height: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.volume_up,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text(
                                      'Nama Dokter:',
                                      style: cTextStyleNormal,
                                    ),
                                    Text(
                                      janjiPeriksa!.namaDokter,
                                      style: cTextStyle2Lite,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text(
                                      'Nama Pasien:',
                                      style: cTextStyleNormal,
                                    ),
                                    Text(
                                      widget.userPassed!.username!,
                                      style: cTextStyle2Lite,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text(
                                      'Tanggal Periksa:',
                                      style: cTextStyleNormal,
                                    ),
                                    Text(
                                      janjiPeriksa!.tglPeriksa,
                                      style: cTextStyle2Lite,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text(
                                      'No. Antrian:',
                                      style: cTextStyleNormal,
                                    ),
                                    Text(
                                      '${janjiPeriksa!.id! + 3}',
                                      style: cTextStyle2Lite,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text(
                                      'Keluhan :',
                                      style: cTextStyleNormal,
                                    ),
                                    Text(
                                      janjiPeriksa!.keluhan,
                                      style: cTextStyle2Lite,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 2.h,
                        ),

                        // FOTO DOKUMEN YG DIUNGGAH
                        if (janjiPeriksa!.dokumen != null)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            // child: _uploadedFileImage,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Foto Dokumen:'),
                                // Image.memory(base64.decode(janjiPeriksa!.dokumen!)),
                                Image.network(janjiPeriksa!.dokumen!),
                              ],
                            ),
                          ),

                        buttonCreatePDF(context)
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
