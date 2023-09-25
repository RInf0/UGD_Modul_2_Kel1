import 'package:flutter/material.dart';
//* Sesuai dengan nama project, awalnya akan error pada home, register, dan form component karena belum ada dibuat
import 'package:ugd_modul_2_kel1/View/home.dart';
import 'package:ugd_modul_2_kel1/View/register.dart';
// import 'package:ugd_modul_2_kel1/component/form_component.dart';

class LoginView extends StatefulWidget {
  //* Variabel map data dibuat bersifat nullabl, karena ketika aplikasi dijalankan(dipanggil dari main, tdak ada yang dibawa)
  //* data memiliki nilai ketika registrasi berhasil dilakukan
  final Map? data;
  //* Agar Map data bisa ebrsifat nullable, pada konstruktor dibungkus dengan kurung ( ) agar bersifat opsional
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //* TextEditingController

    //* widget mengacu pada instance/objek Loginview
    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //* Username
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username tidak boleh kosong";
                    }
                    return null;
                  },
                  controller: usernameController,
                  decoration: const InputDecoration(
                      hintText: "Username",
                      labelText: "Username here",
                      icon: Icon(Icons.person)),
                ),
              ),

              //* Password
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password kosong";
                    }
                    return null;
                  },
                  obscureText: passwordVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password here",
                    icon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              // untuk memberi space antara input dengan button login
              const SizedBox(
                height: 20,
              ),
              //* Baris yang berisi tombol login dan tombol mengarah kehalaman register
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //* tombol login
                  ElevatedButton(
                      //* Fungsi yang dijalankan saat tombol ditekan
                      onPressed: () {
                        //* Cek statenya sudah valid atau belum valid
                        if (_formKey.currentState!.validate()) {
                          //* Jika sudah valid, cek usernamedan password yang diinputkan pada form telah sesuai dengan data yang dibawah
                          //* dari halaman register atau belum
                          if (dataForm!['username'] ==
                                  usernameController.text &&
                              dataForm['password'] == passwordController.text) {
                            //* Jika sesuai navigasi ke halaman home
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeView()));
                          } else {
                            //* Jika belum tampilkan alert dialog
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Password salah'),
                                //* isi alert dialog
                                content: TextButton(
                                    //* pushRegister(context) fungsi pada baris 118-124 untuk meminimalkan nested code
                                    onPressed: () => pushRegister(context),
                                    child: const Text('Daftar Disini !!')),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => pushRegister(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Login')),
                  //* tombol ke halaman register
                  TextButton(
                      onPressed: () {
                        Map<String, dynamic> formData = {};
                        formData['username'] = usernameController.text;
                        formData['password'] = usernameController.text;
                        pushRegister(context);
                      },
                      child: const Text('Belum punya akun ?')),
                ],
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
