import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/client/dokter_client.dart';
import 'package:ugd_modul_2_kel1/entity/dokter.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/document_scanner/edge_detection_scanner.dart';
import 'package:ugd_modul_2_kel1/client/janji_periksa_client.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

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

  bool isLoading = false;

  // data dropdown
  // final List<String> listDokter = ['dr. Natasha', 'dr. Willy', 'dr. John Doe'];
  List<Dokter> listDokter = [];
  String? dropdownValue;

  List<Map<String, dynamic>> userProfile = [];

  int? userId;

  String appBarTitle = '';
  int? selectedDokterId;

  void refresh() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    // final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    // final storedUsername = prefs.getString('username');
    final storedId = prefs.getInt('id');
    userId = storedId;
    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    // final userData =
    //     data.where((user) => user['username'] == storedUsername).toList();
    // final dataJanjiPeriksa = await JanjiPeriksaClient.find(storedId);

    // setState(() {
    //   userProfile = userData;
    // });

    final dataDokter = await DokterClient.fetchAll();

    setState(() {
      listDokter = dataDokter;
      selectedDokterId = dataDokter[0].id;
    });

    if (widget.janjiPeriksa != null) {
      setState(() {
        appBarTitle = 'Edit Janji Periksa';
      });
      tglPeriksaController.text = widget.janjiPeriksa!.tglPeriksa;
      keluhanController.text = widget.janjiPeriksa!.keluhan;
      selectedDokterId = widget.janjiPeriksa!.idDokter;
      if (widget.janjiPeriksa!.dokumen != null) {
        hasImageDokumen = true;
      }
    } else {
      setState(() {
        appBarTitle = 'Tambah Janji Periksa';
      });
    }

    setState(() {
      isLoading = false;
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

    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getInt('id');

    await JanjiPeriksaClient.create(JanjiPeriksa(
      idPasien: storedId,
      idDokter: selectedDokterId,
      namaDokter: dokterController.text,
      tglPeriksa: tglPeriksaController.text,
      keluhan: keluhanController.text,
      dokumen: imgBase64,
    ));
  }

  Future<void> editJanjiPeriksa(int id) async {
    String imgBase64 = '';

    if (imgScanner.encoded != null) {
      imgBase64 = imgScanner.encoded!;
    }

    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getInt('id');

    final dataJanjiPeriksa = JanjiPeriksa(
      id: id,
      idPasien: storedId,
      idDokter: selectedDokterId,
      namaDokter: dokterController.text,
      tglPeriksa: tglPeriksaController.text,
      keluhan: keluhanController.text,
      dokumen: imgBase64,
    );

    await JanjiPeriksaClient.update(dataJanjiPeriksa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: cAccentColor,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: SpinKitThreeBounce(
                  size: 40,
                  color: cAccentColor,
                ),
              )
            : ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 45,
                        ),

                        // Dropdown Dokter
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dokter',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: cAccentColor,
                                ),
                              ),
                              DropdownMenu<int>(
                                key: const Key('dropdown_dokter'),
                                controller: dokterController,
                                initialSelection: selectedDokterId,
                                // widget.janjiPeriksa != null
                                //     ? widget.janjiPeriksa!.idDokter ?? 0
                                //     : listDokter[0].id,
                                onSelected: (int? value) {
                                  setState(() {
                                    selectedDokterId = value;
                                  });
                                },
                                dropdownMenuEntries: listDokter
                                    .map<DropdownMenuEntry<int>>(
                                        (Dokter dokter) {
                                  return DropdownMenuEntry<int>(
                                    value: dokter.id ?? 0,
                                    label: dokter.nama ?? '',
                                  );
                                }).toList(),
                                width: MediaQuery.of(context).size.width * 0.9,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Tanggal Periksa
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Periksa',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: cAccentColor,
                                  ),
                                ),
                                TextFormField(
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
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.calendar_today,
                                    ),
                                    labelText: "Pilih Tanggal",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime? pickeddate = await showDatePicker(
                                      context: context,
                                      initialDate: widget.janjiPeriksa != null
                                          ? DateFormat('dd-MM-yyyy').parse(
                                              widget.janjiPeriksa!.tglPeriksa)
                                          : DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2025),
                                    );
                                    if (pickeddate != null) {
                                      tglPeriksaController.text =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickeddate);
                                    }
                                  },
                                ),
                              ]),
                        ),

                        SizedBox(height: 3.h),

                        // Keluhan
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Keluhan',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: cAccentColor,
                                ),
                              ),
                              TextFormField(
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
                                maxLines: 5,
                                decoration: InputDecoration(
                                  // labelText: "Keluhan",
                                  // prefixIcon: Icon(Icons.notes),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        // tambah dokumen pelengkap
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Foto Dokumen Pelengkap',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: cAccentColor,
                              ),
                            ),
                            Text(
                              'Surat Rujukan, dll. (Opsional)',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: cAccentColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        if (hasImageDokumen)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            // child: _uploadedFileImage,
                            child: Column(
                              children: [
                                const Text('Dokumen Sebelumnya:'),
                                Image.network(widget.janjiPeriksa!.dokumen!),
                                // Image.memory(
                                //   const Base64Decoder()
                                //       .convert(widget.janjiPeriksa!.dokumen!),
                                // ),
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
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 5),
                            //   child: SizedBox(
                            //     child: ElevatedButton(
                            //       onPressed: () async {
                            //         Navigator.pop(context);
                            //       },
                            //       child: const Text('Cancel'),
                            //     ),
                            //   ),
                            // ),

                            // Button Submit
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 29.sp,
                                width: 40.w,
                                child: ElevatedButton(
                                  key: const Key('btnSubmit'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: cAccentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    // validasi form
                                    if (_formKey.currentState!.validate()) {
                                      // refresh();

                                      if (widget.janjiPeriksa != null) {
                                        await editJanjiPeriksa(
                                            widget.janjiPeriksa!.id!);

                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            key: Key(
                                                'snackbar_edit_janji_berhasil'),
                                            content: Text(
                                                'Berhasil Edit Janji Periksa'),
                                          ),
                                        );
                                      } else {
                                        await addJanjiPeriksa();

                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            key: Key(
                                                'snackbar_create_janji_berhasil'),
                                            content: Text(
                                                'Berhasil Tambah Janji Periksa'),
                                          ),
                                        );
                                      }

                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: widget.janjiPeriksa == null
                                      ? const Text('Tambah')
                                      : const Text('Edit'),
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
