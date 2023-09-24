import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ugd_modul_2_kel1/View/login.dart';
import 'package:ugd_modul_2_kel1/component/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //* untuk validasi harus menggunakan GlobayKey
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController notelpController = TextEditingController();

  bool passwordVisible = false;
  bool? isChecked = false;
  String selectedGender = '';

  setSelectedGender(String gender){
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Username Tidak Boleh Kosong';
                  }
                  if (p0.toLowerCase() == 'anjing') {
                    return 'Tidak boleh menggunakan kata kasar';
                  }
                  return null;
                },
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Ucup Surucup",
                    iconData: Icons.person),
                inputForm(((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!p0.contains('@')) {
                    return 'Email harus menggunakan @';
                  }
                  return null;
                }),
                    controller: emailController,
                    hintTxt: "Email",
                    helperTxt: "ucup@gmail.com",
                    iconData: Icons.email),

                //* Password menggunakan visible/invisible toggle
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: SizedBox(
                    width: 400,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password tidak boleh kosong";
                        }
                        if (value.length < 5) {
                          return 'Password minimal 5 digit';
                        }
                        return null;
                      },
                      obscureText: passwordVisible,
                      controller: passwordController,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        helperText: "xxxxxxx",
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock),
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
                ),

                Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: SizedBox(
                  width: 400,
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Date tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: dateController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_outlined),
                      labelText: "Select Date"
                    ),
                    onTap: () async{
                      DateTime? pickeddate = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime(2000), 
                        lastDate: DateTime(2101)
                      );
                      if(pickeddate != null){
                        dateController.text = DateFormat('yyyy-mm-dd').format(pickeddate);
                      }
                    },
                  ),
                ),
                ),

                inputForm(((p0) {
                  //* untuk menglihat contoh penggunaan regex,uncomment baris dibawah yang dicomment
                  //* final RegExp regex = RegExp(r'^\0?[1-9]\d{1,14}$');
                  if (p0 == null || p0.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                  // if(!regex.hasMatch(p0))
                  // {
                  // return 'Nomor Telepon tidak valid';
                  // }
                  return null;
                }),
                    controller: notelpController,
                    hintTxt: "No Telp",
                    helperTxt: "082123456789",
                    iconData: Icons.phone_android),

                Column(
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      Text('Jenis Kelamin',
                      style: TextStyle(fontSize: 16.0),
                      ),
                      RadioListTile(
                        title: Text('Laki-laki'),
                        value: 'Laki-laki',
                        groupValue: selectedGender,
                        onChanged: (value){
                          setSelectedGender('Laki-laki');
                        },
                      ),
                      RadioListTile(
                        title: Text('Perempuan'),
                        value: 'Perempuan',
                        groupValue: selectedGender,
                        onChanged: (value){
                          setSelectedGender('Perempuan');
                        },
                      ),
                      
                    ],
                  ),
                
                Center(
                  child: CheckboxListTile(
                    title: const Text('Apakah Anda memiliki asuransi?'),
                    value: isChecked,
                    onChanged: (bool? newValue){
                      setState(() {
                        isChecked = newValue;
                      });
                    },
                    activeColor: Colors.white,
                    checkColor: Colors.blue,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),

                ElevatedButton(
                    onPressed: () {
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
                              title: const Text('Konfirmasi Pendaftaran'),
                              content: const Text(
                                  'Apakah Anda yakin ingin mendaftar?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Ya'),
                                  onPressed: () {
                                    //*Push data jika memilih 'Ya'
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                LoginView(data: formData)));
                                  },
                                ),
                                TextButton(
                                  child: const Text('Batal'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
