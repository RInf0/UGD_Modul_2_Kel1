import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/document_scanner/edge_detection_scanner.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';

class CreateJanjiPeriksaView extends StatefulWidget {
  const CreateJanjiPeriksaView({super.key, this.janjiPeriksa});

  final JanjiPeriksa? janjiPeriksa;

  @override
  State<CreateJanjiPeriksaView> createState() => _CreateJanjiPeriksaViewState();
}

class _CreateJanjiPeriksaViewState extends State<CreateJanjiPeriksaView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dokterController = TextEditingController();
  TextEditingController tglPeriksaController = TextEditingController();
  TextEditingController keluhanController = TextEditingController();

  // img scanner
  EdgeDetectionScanner imgScanner = EdgeDetectionScanner();
  bool hasImageDokumen = false;

  // data dropdown
  final List<String> listDokter = ['dr. Natasha', 'dr. Willy', 'dr. John Doe'];
  String? dropdownValue;

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
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> addJanjiPeriksa() async {
    String imgBase64 = '';

    if (imgScanner.encoded != null) {
      imgBase64 = imgScanner.encoded!;
    }

    await SQLHelperJanjiPeriksa.addJanjiPeriksa(
      userProfile[0]['id'],
      dokterController.text,
      tglPeriksaController.text,
      keluhanController.text,
      dokumen: imgBase64,
    );
  }

  Future<void> editJanjiPeriksa(int id) async {
    String imgBase64 = '';

    if (imgScanner.encoded != null) {
      imgBase64 = imgScanner.encoded!;
    }

    await SQLHelperJanjiPeriksa.editJanjiPeriksa(
      id,
      userProfile[0]['id'],
      dokterController.text,
      tglPeriksaController.text,
      keluhanController.text,
      dokumen: imgBase64,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.janjiPeriksa != null) {
      tglPeriksaController.text = widget.janjiPeriksa!.tglPeriksa;
      keluhanController.text = widget.janjiPeriksa!.keluhan;
      if (widget.janjiPeriksa!.dokumen != '') {
        hasImageDokumen = true;
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 45,
                  ),

                  // Title
                  const Text(
                    'Buat Jadwal Periksa',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                        fontWeight: FontWeight.w500),
                  ),

                  // Dropdown Dokter
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: DropdownMenu<String>(
                      controller: dokterController,
                      initialSelection: widget.janjiPeriksa != null
                          ? widget.janjiPeriksa!.namaDokter
                          : listDokter.first,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries: listDokter
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        );
                      }).toList(),
                    ),
                  ),

                  // Tanggal Periksa
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
                      // hide keyboard ketika input date ditap
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tanggal Periksa tidak boleh kosong";
                        }
                        return null;
                      },
                      controller: tglPeriksaController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: "Tanggal Periksa",
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: widget.janjiPeriksa != null
                                ? DateFormat('dd-MM-yyyy')
                                    .parse(widget.janjiPeriksa!.tglPeriksa)
                                : DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025));
                        if (pickeddate != null) {
                          tglPeriksaController.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        }
                      },
                    ),
                  ),

                  // Keluhan
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Keluhan tidak boleh kosong';
                        }
                        if (value.toLowerCase() == 'anjing') {
                          return 'Tidak boleh menggunakan kata kasar';
                        }
                        return null;
                      },
                      controller: keluhanController,
                      decoration: const InputDecoration(
                        labelText: "Keluhan",
                        prefixIcon: Icon(Icons.notes),
                      ),
                    ),
                  ),

                  // tambah dokumen pelengkap
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Foto Dokumen Pelengkap, Surat Rujukan, dll. (Opsional)',
                      ),
                    ],
                  ),

                  if (hasImageDokumen)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      // child: _uploadedFileImage,
                      child: Column(
                        children: [
                          const Text('Dokumen Sebelumnya:'),
                          Image.memory(
                            const Base64Decoder()
                                .convert(widget.janjiPeriksa!.dokumen!),
                          ),
                        ],
                      ),
                    ),

                  imgScanner,

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Button Cancel
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                      ),

                      // Button Submit
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              // validasi form
                              if (_formKey.currentState!.validate()) {
                                // refresh();

                                if (widget.janjiPeriksa != null) {
                                  await editJanjiPeriksa(
                                      widget.janjiPeriksa!.id!);
                                } else {
                                  await addJanjiPeriksa();
                                }

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}