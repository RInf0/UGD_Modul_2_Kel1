import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/input_janji_periksa.dart';

class DetailJanjiPeriksaView extends StatefulWidget {
  const DetailJanjiPeriksaView({super.key, required this.janjiPeriksaPassed});

  final JanjiPeriksa? janjiPeriksaPassed;

  @override
  State<DetailJanjiPeriksaView> createState() => _DetailJanjiPeriksaViewState();
}

class _DetailJanjiPeriksaViewState extends State<DetailJanjiPeriksaView> {
  JanjiPeriksa? janjiPeriksa;

  FlutterTts tts = FlutterTts();

  void textToSpeech(String text) async {
    await tts.setLanguage('id-ID');
    await tts.setVolume(0.8);
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);
    await tts.speak(text);
  }

  Future<void> deleteJanjiPeriksa(int id) async {
    await SQLHelperJanjiPeriksa.deleteJanjiPeriksa(id);
    refresh();
  }

  void refresh() async {
    // update data janji periksa menjadi yang terbaru
    final list = await SQLHelperJanjiPeriksa.getJanjiPeriksa();
    final dataJP = list
        .where((janjiPeriksa) => janjiPeriksa['id'] == this.janjiPeriksa!.id)
        .toList();

    JanjiPeriksa janjiPeriksaUpdated = JanjiPeriksa(
      id: dataJP[0]['id'],
      idPasien: dataJP[0]['id_pasien'],
      namaDokter: dataJP[0]['nama_dokter'],
      tglPeriksa: dataJP[0]['tgl_periksa'],
      keluhan: dataJP[0]['keluhan'],
      dokumen: dataJP[0]['dokumen'],
    );

    setState(() {
      janjiPeriksa = janjiPeriksaUpdated;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    janjiPeriksa = widget.janjiPeriksaPassed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 50,
                      width: 50,
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
                          height: 120,
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
                  if (janjiPeriksa!.dokumen != '')
                    Padding(
                      padding: const EdgeInsets.all(20),
                      // child: _uploadedFileImage,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Foto Dokumen:'),
                          Image.memory(
                            const Base64Decoder()
                                .convert(janjiPeriksa!.dokumen!),
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
                                    dokumen: janjiPeriksa!.dokumen,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
