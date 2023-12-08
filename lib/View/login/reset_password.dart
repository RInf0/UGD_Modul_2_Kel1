import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/client/auth_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
//* Sesuai dengan nama project, awalnya akan error pada home, register, dan form component karena belum ada dibuat
import 'package:ugd_modul_2_kel1/view/home/home.dart';
import 'package:ugd_modul_2_kel1/view/register/register.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
// import 'package:ugd_modul_2_kel1/component/form_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordView extends StatefulWidget {
  //* Variabel map data dibuat bersifat nullabl, karena ketika aplikasi dijalankan(dipanggil dari main, tdak ada yang dibawa)
  //* data memiliki nilai ketika registrasi berhasil dilakukan
  // final Map? data;
  //* Agar Map data bisa ebrsifat nullable, pada konstruktor dibungkus dengan kurung ( ) agar bersifat opsional
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  bool passwordInvisible = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Map<String, dynamic>> listUser = [];

  User? userFound;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //* TextEditingController
    //* widget mengacu pada instance/objek ResetPasswordView
    // Map? dataForm = widget.data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cAccentColor,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                // Title
                const Text(
                  'Ganti Password',
                  style: TextStyle(
                    fontSize: 35,
                    color: cAccentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(
                  height: 3.h,
                ),

                //* Username
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: TextFormField(
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username tidak boleh kosong";
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      labelText: "Username",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),

                //* Password
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password tidak boleh kosong";
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      labelText: "Password Baru",
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

                // untuk memberi space antara input dengan button login
                SizedBox(
                  height: 7.h,
                ),

                //* Baris yang berisi tombol reset
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
                        //* Fungsi yang dijalankan saat tombol ditekan
                        onPressed: () async {
                          //* Cek statenya sudah valid atau belum valid
                          if (_formKey.currentState!.validate()) {
                            //* Jika sudah valid, cek username dan password yang diinputkan pada form telah sesuai dengan data yang dibawah
                            //* dari halaman register atau belum

                            // API

                            // refresh();

                            try {
                              await AuthClient.resetPassword(User(
                                username: usernameController.text,
                                password: passwordController.text,
                              ));
                              // ignore: use_build_context_synchronously
                              showSnackBar(context, 'Password berhasil direset',
                                  Colors.green);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              showSnackBar(context, e.toString(), Colors.red);
                              // ignore: use_build_context_synchronously
                              // Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('Ganti Password')),
                  ),
                ),

                //* tombol ke halaman login
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Map<String, dynamic> formData = {};
                    formData['username'] = usernameController.text;
                    formData['password'] = usernameController.text;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Batal',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
        label: 'hide',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}
