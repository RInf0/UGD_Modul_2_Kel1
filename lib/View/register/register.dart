import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ugd_modul_2_kel1/client/auth_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
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
                  const SizedBox(
                    height: 45,
                  ),

                  // Title
                  const Text(
                    'Register',
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
                      key: Key('usernameTest'),
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
                      key: Key('emailTest'),
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
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
                      key: Key('passwordTest'),
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
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        tglLahirController.text =
                            '${date!.day}/${date.month}/${date.year}';
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          key: const Key('tglLahirTest'),
                          controller: tglLahirController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.date_range),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.5),
                            ),
                            labelText: 'Date of Birth',
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                tglLahirController.text =
                                    '${date!.day}/${date.month}/${date.year}';
                              },
                              icon: const Icon(Icons.date_range),
                            ),
                          ),
                          validator: (value) =>
                              value == '' ? 'Please select a birth date' : null,
                          onTap: () {
                            // Ini mencegah keyboard dari muncul saat menekan TextFormField
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ),
                    ),
                  ),

                  // Nomor Telepon
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: TextFormField(
                      key: Key('noTelpTest'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        final RegExp regex = RegExp(r'^\0?[1-9]\d{1,14}$');
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
                        key: Key('genderMaleTest'),
                        title: const Text('Laki-laki'),
                        value: 'Laki-laki',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setSelectedGender('Laki-laki');
                        },
                      ),
                      RadioListTile(
                        key: Key('genderFemaleTest'),
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
                      width: double.infinity,
                      child: ElevatedButton(
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Register Berhasil'),
                                          ),
                                        );
                                        // await addUser();

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

  Future<bool> isEmail(String email) async {
    final data = await SQLHelper.checkEmail(email);
    return data.isNotEmpty;
  }
}
