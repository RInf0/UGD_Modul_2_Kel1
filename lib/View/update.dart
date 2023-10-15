import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ugd_modul_2_kel1/View/home.dart';
import 'package:ugd_modul_2_kel1/View/login.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:ugd_modul_2_kel1/View/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UpdateView extends StatefulWidget {
  const UpdateView({
    super.key,
    required this.id,
    required this.username,
    required this.password,
    required this. email,
    required this.tgl_lahir,
    required this.no_telp,
    });

    final String?username, password, email, tgl_lahir, no_telp;
    final int? id;
  
  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
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

  setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }


  @override
  Widget build(BuildContext context) {
    // if(widget.id != null){
    //   usernameController.text = widget.username!;
    //   emailController.text = widget.email!;
    //   passwordController.text = widget.password!;
    //   tglLahirController.text = widget.tgl_lahir!;
    //   noTelpController.text =widget.no_telp!;
    // }
    return Scaffold(
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
                    'Update',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.green,
                        fontWeight: FontWeight.w500),
                  ),

                  // Username
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: TextFormField(
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
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),

                  // Email
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!value.contains('@')) {
                          return 'Email harus menggunakan @';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),

                  // Password
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
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
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
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
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: "Tanggal Lahir",
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());
                        if (pickeddate != null) {
                          tglLahirController.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        }
                      },
                    ),
                  ),

                  // Nomor Telepon
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        final RegExp regex = RegExp(r'^\0?[1-9]\d{1,14}$');
                        if (value == null || value.isEmpty) {
                          return "Nomor Telepon tidak boleh kosong";
                        }
                        if (regex.hasMatch(value)) {
                          return "Nomor Telepon tidak valid";
                        }
                        return null;
                      },
                      controller: noTelpController,
                      decoration: const InputDecoration(
                        labelText: "No. Telepon",
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                    ),
                  ),


                  const SizedBox(
                    height: 20,
                  ),

                  // Button Register
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          

                          // validasi form
                          if (_formKey.currentState!.validate()) {
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
                                  title: const Text('Konfirmasi Update'),
                                  content: const Text(
                                      'Apakah Anda yakin ingin Update Data'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Batal'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Ya'),
                                      onPressed: () async {
                                        await editEmployee(widget.id!);

                                        //*Push data jika memilih 'Ya'
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const HomeView()));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ),
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

  Future<void> editEmployee(int id) async {
  await SQLHelper.editUser(id, usernameController.text, emailController.text, passwordController.text, tglLahirController.text, noTelpController.text);

  // Setelah mengedit data, Anda dapat menyimpan data yang baru dalam SharedPreferences.
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('username', usernameController.text);

  // Kemudian kembali ke halaman profil atau tindakan lain sesuai kebutuhan aplikasi Anda.
  Navigator.push(context, MaterialPageRoute(builder: (_) => const Profile()));
}
}
