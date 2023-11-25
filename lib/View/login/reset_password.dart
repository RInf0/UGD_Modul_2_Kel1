import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/client/auth_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              const Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
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
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),

              //* Password
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
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

              // untuk memberi space antara input dengan button login
              const SizedBox(
                height: 30.0,
              ),

              //* Baris yang berisi tombol login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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

                          // User data = await AuthClient.login(User(
                          //   username: usernameController.text,
                          //   password: passwordController.text,
                          // ));

                          // if (userFound is User) {
                          // } else {
                          //   userFound = null;
                          // }

                          // print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                          // // print(userFound!.username);

                          // if (userFound!.id != null) {
                          //   final prefs = await SharedPreferences.getInstance();
                          //   prefs.setString(
                          //     'username',
                          //     userFound!.username!,
                          //   );
                          //   prefs.setInt(
                          //     'id',
                          //     userFound!.id!,
                          //   );

                          //   // ignore: use_build_context_synchronously
                          //   Navigator.pop(context);
                          // } else {
                          //   // ignore: use_build_context_synchronously
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
                      child: const Text('Reset Password')),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
