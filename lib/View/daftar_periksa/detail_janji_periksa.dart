import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ugd_modul_2_kel1/client/janji_periksa_client.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/pdf/pdf_view.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/input_janji_periksa.dart';
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
    // await SQLHelperJanjiPeriksa.deleteJanjiPeriksa(id);
    await JanjiPeriksaClient.destroy(id);
    refresh();
  }

  void refresh() async {
    // update data janji periksa menjadi yang terbaru
    // final list = await SQLHelperJanjiPeriksa.getJanjiPeriksa();
    // final dataJP = list
    //     .where((janjiPeriksa) => janjiPeriksa['id'] == this.janjiPeriksa!.id)
    //     .toList();

    final dataJP = await JanjiPeriksaClient.find(widget.janjiPeriksaPassed!.id);

    // await Future.delayed(const Duration(milliseconds: 500));

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
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      width: 80.w,
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
          backgroundColor: Colors.greenAccent,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            // height = 15.sp;
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (janjiPeriksa == null) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
              // child: CircularProgressIndicator(),
              ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Janji Periksa'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
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
                      width: 50,
                      // height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.volume_up,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 120,
                          // height: 120,
                          child: Image.asset(
                            'image/${janjiPeriksa!.namaDokter.toLowerCase()}.jpg',
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
                            Text(janjiPeriksa!.idPasien.toString()),
                            Text(janjiPeriksa!.tglPeriksa),
                            Text(janjiPeriksa!.namaDokter),
                            Text(janjiPeriksa!.keluhan),
                          ],
                        ),
                      )
                    ],
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
                          Image.memory(
                              // Uri.parse(janjiPeriksa!.dokumen!)
                              //       .data!
                              //       .contentAsBytes()

                              base64.decode(janjiPeriksa!.dokumen!)

                              // base64Decode(
                              //   janjiPeriksa!.dokumen!
                              //       .replaceAll(RegExp(r'\s'), ''),
                              // ),

                              // const Base64Decoder().convert(
                              //   janjiPeriksa!.dokumen!
                              //       .replaceAll(RegExp(r'\s'), ''),
                              // ),
                              ),
                        ],
                      ),
                    ),

                  // BUTTONS
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
                                builder: (_) => CreateJanjiPeriksaView(
                                  janjiPeriksa: JanjiPeriksa(
                                    id: janjiPeriksa!.id,
                                    idPasien: janjiPeriksa!.idPasien,
                                    namaDokter: janjiPeriksa!.namaDokter,
                                    tglPeriksa: janjiPeriksa!.tglPeriksa,
                                    keluhan: janjiPeriksa!.keluhan,
                                    // dokumen: janjiPeriksa!.dokumen,
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
                            await deleteJanjiPeriksa(janjiPeriksa!.id!);
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
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
