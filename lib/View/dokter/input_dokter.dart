import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/client/dokter_client.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/dokter.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class InputDokterView extends StatefulWidget {
  const InputDokterView({super.key, this.dokter});

  final Dokter? dokter;

  @override
  State<InputDokterView> createState() => _InputDokterViewState();
}

class _InputDokterViewState extends State<InputDokterView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  // data dropdown
  final List<String> listJob = [
    'Spesialis Saraf',
    'Bedah Digestif',
    'Spesialis Anak',
    'Neurologi',
    'Spesialis Jantung',
    'Spesialis Kanker',
    'Gastrologi',
    'Hematologi',
    'Spesialis Paru',
    'Dokter Umum',
  ];
  String? dropdownValue;

  int? userId;

  String appBarTitle = 'Tambah Dokter';

  void refresh() async {
    // final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    // final storedUsername = prefs.getString('username');
    final storedId = prefs.getInt('id');
    userId = storedId;

    if (widget.dokter != null) {
      setState(() {
        appBarTitle = 'Edit Dokter';
      });
      namaController.text = widget.dokter!.nama!;
      noTelpController.text = widget.dokter!.noTelp!;
      jobController.text = widget.dokter!.job!;
    }
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> addDokter() async {
    await DokterClient.create(Dokter(
      nama: namaController.text,
      noTelp: noTelpController.text,
      job: jobController.text,
    ));
  }

  Future<void> editDokter(int id) async {
    final dataDokter = Dokter(
      id: id,
      nama: namaController.text,
      noTelp: noTelpController.text,
      job: jobController.text,
    );

    await DokterClient.update(dataDokter);
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
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h),

                  // Nama Dokter
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Dokter',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: cAccentColor,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama dokter tidak boleh kosong';
                            }
                            return null;
                          },
                          controller: namaController,
                          decoration: InputDecoration(
                            // labelText: "Nama Dokter",
                            // prefixIcon: Icon(Icons.notes),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // No. Telepon Dokter
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No. Telepon Dokter',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: cAccentColor,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            final RegExp regex = RegExp(r'^\0?[0-9]\d{1,14}$');
                            if (value == null || value.isEmpty) {
                              return "Nomor Telepon tidak boleh kosong";
                            }
                            if (!regex.hasMatch(value)) {
                              return "Nomor Telepon tidak valid";
                            }
                            return null;
                          },
                          controller: noTelpController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Dropdown Job Dokter
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Job/Spesialisasi',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: cAccentColor,
                          ),
                        ),
                        DropdownMenu<String>(
                          menuHeight: 200,
                          key: const Key('dropdown_job_dokter'),
                          controller: jobController,
                          initialSelection: widget.dokter != null
                              ? widget.dokter!.job
                              : listJob.first,
                          onSelected: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: listJob
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

                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Button Submit
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          height: 29.sp,
                          width: 40.w,
                          child: ElevatedButton(
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

                                if (widget.dokter != null) {
                                  await editDokter(widget.dokter!.id!);

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      key: Key('snackbar_edit_dokter_berhasil'),
                                      content: Text('Berhasil Edit Dokter'),
                                    ),
                                  );
                                } else {
                                  await addDokter();

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      key: Key(
                                          'snackbar_create_dokter_berhasil'),
                                      content: Text('Berhasil Tambah Dokter'),
                                    ),
                                  );
                                }

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: widget.dokter == null
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
