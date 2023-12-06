import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/client/auth_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
import 'package:ugd_modul_2_kel1/view/login/login.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();

  bool passwordInvisible = true;
  bool? isChecked = false;
  bool _showErrorJenisKelamin = false;
  String selectedGender = '';
  bool isExist = false;

  setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  Future<void> addUser() async {
    // CODE LAMA PAKAI SQFLITE
    //
    // await SQLHelper.addUser(
    //   usernameController.text,
    //   emailController.text,
    //   passwordController.text,
    //   tglLahirController.text,
    //   noTelpController.text,
    // );

    final dataRegister = User(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      tglLahir: tglLahirController.text,
      noTelp: noTelpController.text,
    );

    await AuthClient.register(dataRegister);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  // logo
                  // imageLogoAtmaHospital(),
                  textTitleAtmaHospital(fontSize: 25),
                  SizedBox(
                    height: 0.1.h,
                  ),
                  textSloganAtmaHospital(),

                  SizedBox(
                    height: 2.h,
                  ),

                  // Username
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: TextFormField(
                      key: const Key('usernameTest'),
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        if (value.toLowerCase() == 'anjing') {
                          return 'Tidak boleh menggunakan kata kasar';
                        }
                        return null;
                      },
                      controller: usernameController,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Color(0xffEAEAEA),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),

                  // Email
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 15, right: 20),
                    child: TextFormField(
                      key: const Key('emailTest'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!value.contains('@')) {
                          return 'Email harus menggunakan @';
                        }
                        if (isExist) {
                          return 'Email sudah digunakan';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Color(0xffEAEAEA),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      onChanged: (value) async {
                        // isExist = await isEmail(value);
                        // setState(() {
                        //   isExist;
                        // });
                      },
                    ),
                  ),

                  // Password
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 15, right: 20),
                    child: TextFormField(
                      key: const Key('passwordTest'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password tidak boleh kosong";
                        }
                        if (value.length < 5) {
                          return 'Password minimal 5 karakter';
                        }
                        return null;
                      },
                      obscureText: passwordInvisible,
                      controller: passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: const Color(0xffEAEAEA),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passwordInvisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                              () {
                                passwordInvisible = !passwordInvisible;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Tanggal Lahir
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, right: 20),
                      child: TextFormField(
                        key: const Key('tglLahirTest'),
                        // hide keyboard ketika input date ditap
                        keyboardType: TextInputType.none,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Tanggal Lahir tidak boleh kosong";
                          }
                          return null;
                        },
                        controller: tglLahirController,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Color(0xffEAEAEA),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: "Tanggal Lahir",
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickeddate != null) {
                            tglLahirController.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate);
                          }
                        },
                      )
                      // child: GestureDetector(
                      //   onTap: () async {
                      //     final date = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(1900),
                      //       lastDate: DateTime.now(),
                      //     );
                      //     tglLahirController.text =
                      //         '${date!.day}/${date.month}/${date.year}';
                      //   },
                      //   child: AbsorbPointer(
                      //     child: TextFormField(
                      //       key: const Key('tglLahirTest'),
                      //       controller: tglLahirController,
                      //       decoration: InputDecoration(
                      //         prefixIcon: const Icon(Icons.date_range),
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(50.5),
                      //         ),
                      //         labelText: 'Date of Birth',
                      //         suffixIcon: IconButton(
                      //           onPressed: () async {
                      //             final date = await showDatePicker(
                      //               context: context,
                      //               initialDate: DateTime.now(),
                      //               firstDate: DateTime(1900),
                      //               lastDate: DateTime.now(),
                      //             );
                      //             tglLahirController.text =
                      //                 '${date!.day}/${date.month}/${date.year}';
                      //           },
                      //           icon: const Icon(Icons.date_range),
                      //         ),
                      //       ),
                      //       validator: (value) =>
                      //           value == '' ? 'Please select a birth date' : null,
                      //       onTap: () {
                      //         // Ini mencegah keyboard dari muncul saat menekan TextFormField
                      //         FocusScope.of(context).requestFocus(FocusNode());
                      //       },
                      //     ),
                      //   ),
                      // ),
                      ),

                  // Nomor Telepon
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 15, right: 20),
                    child: TextFormField(
                      key: const Key('noTelpTest'),
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
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Color(0xffEAEAEA),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: "No. Telepon",
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                    ),
                  ),

                  // Jenis Kelamin
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 30.0),
                      const Text(
                        'Jenis Kelamin',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      RadioListTile(
                        key: const Key('genderMaleTest'),
                        title: const Text('Laki-laki'),
                        value: 'Laki-laki',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setSelectedGender('Laki-laki');
                        },
                      ),
                      RadioListTile(
                        key: const Key('genderFemaleTest'),
                        title: const Text('Perempuan'),
                        value: 'Perempuan',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setSelectedGender('Perempuan');
                        },
                      ),
                    ],
                  ),
                  if (_showErrorJenisKelamin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 25, bottom: 10),
                          child: Text(
                            'Jenis Kelamin harus dipilih',
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 12),
                          ),
                        )
                      ],
                    ),

                  // Checkbox BPJS
                  CheckboxListTile(
                    title: const Text('Saya memiliki BPJS'),
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue;
                      });
                    },
                    activeColor: Colors.transparent,
                    checkColor: Colors.green,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Button Register
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 30.sp,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 18, 18, 18),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        key: const Key('registerClick'),
                        onPressed: () {
                          // munculkan text validasi/error handling merah ketika radio button jenis kelamin kosong
                          setState(() {
                            if (selectedGender.isEmpty) {
                              _showErrorJenisKelamin = true;
                            } else {
                              _showErrorJenisKelamin = false;
                              // lalu simpan jenis kelamin
                            }
                          });

                          bool success = false;

                          // validasi form
                          if (_formKey.currentState!.validate() &&
                              selectedGender.isNotEmpty) {
                            // ScaffoldMessenger.of(context).showSnackBar{
                            // const SnackBar(content: Text('Processing Data))};
                            Map<String, dynamic> formData = {};
                            formData['username'] = usernameController.text;
                            formData['password'] = passwordController.text;
                            //* Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext) => LoginView(data: formData ,)) );

                            //Navigator; //.push(context, MaterialPageRoute(builder: (_) => LoginView(data: formData ,)) );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Konfirmasi Pendaftaran'),
                                  content: const Text(
                                      'Apakah Anda yakin ingin mendaftar?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Batal'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      key: const Key('yesButton'),
                                      child: const Text('Ya'),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                              child: SpinKitThreeBounce(
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        );

                                        await Future.delayed(
                                            const Duration(seconds: 2));

                                        await addUser();

                                        if (mounted) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              key: Key(
                                                  'snackbar_register_berhasil'),
                                              content:
                                                  Text('Register Berhasil'),
                                            ),
                                          );
                                        }

                                        //*Push data jika memilih 'Ya'
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => LoginView()));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 2.h,
                  ),

                  //* tombol ke halaman login
                  TextButton(
                    key: const Key('button_login_here'),
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      // Map<String, dynamic> formData = {};
                      // formData['username'] = usernameController.text;
                      // formData['password'] = usernameController.text;
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun? ',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const Text(
                            'Login',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> isEmail(String email) async {
    final data = await SQLHelper.checkEmail(email);
    return data.isNotEmpty;
  }
}
