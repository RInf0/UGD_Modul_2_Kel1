// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/View/dokter/daftar_dokter.dart';
import 'package:ugd_modul_2_kel1/View/login/reset_password.dart';
import 'package:ugd_modul_2_kel1/client/auth_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
//* Sesuai dengan nama project, awalnya akan error pada home, register, dan form component karena belum ada dibuat
import 'package:ugd_modul_2_kel1/view/home/home.dart';
import 'package:ugd_modul_2_kel1/view/register/register.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
// import 'package:ugd_modul_2_kel1/component/form_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  //* Variabel map data dibuat bersifat nullabl, karena ketika aplikasi dijalankan(dipanggil dari main, tdak ada yang dibawa)
  //* data memiliki nilai ketika registrasi berhasil dilakukan
  // final Map? data;
  //* Agar Map data bisa ebrsifat nullable, pada konstruktor dibungkus dengan kurung ( ) agar bersifat opsional
  LoginView({
    super.key,
    this.firstInputController,
    this.secondInputController,
    this.result,
    this.onLogin,
  });

  TextEditingController? firstInputController;
  TextEditingController? secondInputController;
  String? result;
  Function? onLogin;
  // final Function(double, double, String) onCalculate;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

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
    if (widget.firstInputController != null) {
      setState(() {
        usernameController = widget.firstInputController!;
        passwordController = widget.secondInputController!;
      });
    }

    //* TextEditingController
    //* widget mengacu pada instance/objek Loginview
    // Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),

                  // logo
                  imageLogoAtmaHospital(),
                  textTitleAtmaHospital(fontSize: 25),
                  SizedBox(
                    height: 0.1.h,
                  ),
                  textSloganAtmaHospital(),

                  SizedBox(
                    height: 2.h,
                  ),

                  //* Username
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),

                  //* Password
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 15, right: 20),
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

                  SizedBox(
                    height: 0.6.h,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            pushForgotPassword(context);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // untuk memberi space antara input dengan button login
                  SizedBox(
                    height: 5.h,
                  ),

                  //* Baris yang berisi tombol login
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
                        key: const Key('button_login'),
                        //* Fungsi yang dijalankan saat tombol ditekan
                        onPressed: () async {
                          //* Cek statenya sudah valid atau belum valid

                          // widget.onLogin!(
                          //   usernameController.text,
                          //   passwordController.text,
                          //   'login',
                          // );

                          // return;

                          if (_formKey.currentState!.validate()) {
                            //* Jika sudah valid, cek username dan password yang diinputkan pada form telah sesuai dengan data yang dibawah
                            //* dari halaman register atau belum

                            // API

                            // refresh();

                            // SEMENTARA COMMENT DULU BUAT TESTING ====================

                            setState(() {
                              isLoading = true;
                            });

                            await Future.delayed(const Duration(seconds: 2));

                            User data = await AuthClient.login(User(
                              username: usernameController.text,
                              password: passwordController.text,
                            ));

                            userFound = data;

                            setState(() {
                              isLoading = false;
                            });

                            // if (userFound is User) {
                            // } else {
                            //   userFound = null;
                            // }

                            // print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                            // print(userFound!.username);

                            if (userFound!.id != null) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                'username',
                                userFound!.username!,
                              );
                              prefs.setInt(
                                'id',
                                userFound!.id!,
                              );

                              // ignore: use_build_context_synchronously
                              if (userFound!.username! == 'admin') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const DaftarDokterView(
                                              isUserAdmin: true,
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeView()));
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text(
                                      'Username atau password salah!'),
                                  //* isi alert dialog
                                  actions: <Widget>[
                                    TextButton(
                                      //* pushRegister(context) fungsi pada baris 118-124 untuk meminimalkan nested code
                                      onPressed: () => pushRegister(context),
                                      child: const Text('Register'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            // CODE LAMA PAKAI SQFLITE

                            // final data = await SQLHelper.getUser();
                            // listUser = data;

                            // Map<String, dynamic>? userLoggedIn;

                            // for (Map<String, dynamic> user in listUser) {
                            //   if (user['username'] == usernameController.text &&
                            //       user['password'] == passwordController.text) {
                            //     userLoggedIn = user;
                            //   }
                            // }
                            // if (userLoggedIn != null) {
                            //   final prefs = await SharedPreferences.getInstance();
                            //   prefs.setString(
                            //       'username', userLoggedIn['username']);
                            //   // ignore: use_build_context_synchronously
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (_) => const HomeView()));
                            // } else {
                            //   showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //       title:
                            //           const Text('Username atau password salah!'),
                            //       //* isi alert dialog
                            //       actions: <Widget>[
                            //         TextButton(
                            //           //* pushRegister(context) fungsi pada baris 118-124 untuk meminimalkan nested code
                            //           onPressed: () => pushRegister(context),
                            //           child: const Text('Register'),
                            //         ),
                            //         TextButton(
                            //           onPressed: () => Navigator.pop(context),
                            //           child: const Text('Ok'),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // }
                          }
                        },
                        child: isLoading
                            ? const SpinKitThreeBounce(
                                size: 30,
                                color: Colors.white,
                              )
                            : Text(
                                'Login',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                      ),
                    ),
                  ),

                  //* tombol ke halaman register
                  TextButton(
                    key: const Key('button_register_here'),
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      // Map<String, dynamic> formData = {};
                      // formData['username'] = usernameController.text;
                      // formData['password'] = usernameController.text;
                      pushRegister(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum punya akun? ',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const Text(
                            'Register',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
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

  void pushForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ResetPasswordView(),
      ),
    );
  }
}
