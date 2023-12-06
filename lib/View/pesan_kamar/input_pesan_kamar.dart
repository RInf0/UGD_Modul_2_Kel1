import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/client/pesan_kamar_client.dart';
import 'package:ugd_modul_2_kel1/entity/pesan_kamar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class CreatePesanKamarView extends StatefulWidget {
  const CreatePesanKamarView({super.key, this.pesanKamar});

  final PesanKamar? pesanKamar;

  @override
  State<CreatePesanKamarView> createState() => _CreatePesanKamarViewState();
}

class _CreatePesanKamarViewState extends State<CreatePesanKamarView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController kelasController = TextEditingController();
  TextEditingController spesialisasiController = TextEditingController();
  TextEditingController usiaController = TextEditingController();
  TextEditingController tglPesanController = TextEditingController();

  final List<String> listKelas = ['Kelas 1', 'Kelas 2', 'Kelas 3', 'VIP'];
  final List<String> listSpesialisasi = [
    'KSM Bedah',
    'KSM Jantung',
    'KSM Anestesiologi',
    'Semua Kasus'
  ];
  final List<String> listUsia = ['Anak-anak', 'Remaja', 'Dewasa'];

  String? valueKelas, valueSpesialisasi, valueUsia;
  int? userId;

  void refresh() async {
    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getInt('id');
    userId = storedId;
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> addPesanKamar() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id');

    await PesanKamarClient.create(PesanKamar(
        idUser: userId,
        kelas: kelasController.text,
        spesialisasi: spesialisasiController.text,
        usia: usiaController.text,
        tglPesan: tglPesanController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pemesanan Kamar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),

                  //dropdown kelas
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelas',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        DropdownMenu<String>(
                          key: const Key('dropdown_kelas'),
                          controller: kelasController,
                          initialSelection: widget.pesanKamar != null
                              ? widget.pesanKamar!.kelas
                              : listKelas.first,
                          onSelected: (String? value) {
                            setState(() {
                              valueKelas = value!;
                            });
                          },
                          dropdownMenuEntries: listKelas
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList(),
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  //dropdown spesialisasi
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spesialisasi',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        DropdownMenu<String>(
                          key: const Key('dropdown_spesialisasi'),
                          controller: spesialisasiController,
                          initialSelection: widget.pesanKamar != null
                              ? widget.pesanKamar!.spesialisasi
                              : listSpesialisasi.first,
                          onSelected: (String? value) {
                            setState(() {
                              valueSpesialisasi = value!;
                            });
                          },
                          dropdownMenuEntries: listSpesialisasi
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList(),
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  //dropdown usia
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Usia',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        DropdownMenu<String>(
                          key: const Key('dropdown_usia'),
                          controller: usiaController,
                          initialSelection: widget.pesanKamar != null
                              ? widget.pesanKamar!.usia
                              : listUsia.first,
                          onSelected: (String? value) {
                            setState(() {
                              valueUsia = value!;
                            });
                          },
                          dropdownMenuEntries: listUsia
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList(),
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  //tanggal pesan
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Pesan Kamar',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
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
                          controller: tglPesanController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                            ),
                            labelText: "Pilih Tanggal",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: widget.pesanKamar != null
                                  ? DateFormat('dd-MM-yyyy')
                                      .parse(widget.pesanKamar!.tglPesan)
                                  : DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );
                            if (pickeddate != null) {
                              tglPesanController.text =
                                  DateFormat('dd-MM-yyyy').format(pickeddate);
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 5.h),

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

                                // if (widget.pesanKamar != null) {
                                //   await editJanjiPeriksa(
                                //       widget.janjiPeriksa!.id!);

                                //   // ignore: use_build_context_synchronously
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       key: Key('snackbar_edit_janji_berhasil'),
                                //       content:
                                //           Text('Berhasil Edit Janji Periksa'),
                                //     ),
                                //   );
                                // } else {
                                await addPesanKamar();

                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    key: Key(
                                        'snackbar_create_pesan_kamar_berhasil'),
                                    content:
                                        Text('Berhasil Tambah Pesan Kamar'),
                                  ),
                                );
                                // }

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                    ],
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
