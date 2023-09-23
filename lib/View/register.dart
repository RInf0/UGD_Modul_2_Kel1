import 'package:flutter/material.dart';
import 'package:guidedlayout2_1212/View/login.dart';
import 'package:guidedlayout2_1212/component/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //* untuk validasi harus menggunakan GlokayKey
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputForm(
                (p0) {
                  if(p0 == null || p0.isEmpty)
                  {
                    return 'Username Tidak Boleh Kosong';
                  }
                  if(p0.toLowerCase() == 'anjing'){
                    return 'Tidak boleh menggunakan kata kasar';
                  }
                  return null;
                },
                controller: usernameController,
                hintTxt: "Username",
                helperTxt: "Ucup Surucup",
                iconData: Icons.person),

              inputForm(
                ((p0){
                  if(p0 == null || p0.isEmpty)
                  {
                    return 'Email tidak boleh kosong';
                  }
                  if(!p0.contains('@'))
                  {
                    return 'Email harus menggunakan @';
                  }
                  return null;
                }),
                controller: emailController,
                hintTxt: "Email",
                helperTxt: "ucup@gmail.com",
                iconData: Icons.email),

              inputForm(
                //* Pola validasi lebih detail bisa menggunakan regex
                ((p0){
                  if(p0 == null || p0.isEmpty)
                  {
                    return 'Password tidak boleh kosong';
                  }
                  if(p0.length<5)
                  {
                    return 'Password minimal 5 digit';
                  }
                  return null;
                }),
                controller: passwordController,
                hintTxt: "Password",
                helperTxt: "xxxxxxx",
                iconData: Icons.password,
                password: true),

              inputForm(
                ((p0){
                  //* untuk menglihat contoh penggunaan regex,uncomment baris dibawah yang dicomment
                  //* final RegExp regex = RegExp(r'^\0?[1-9]\d{1,14}$');
                  if(p0 == null || p0.isEmpty)
                  {
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

            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  
                  // ScaffoldMessenger.of(context).showSnackBar{
                  // const SnackBar(content: Text('Processing Data))};
                  Map<String,dynamic> formData = {};
                  formData['username'] = usernameController.text;
                  formData['password'] = passwordController.text;
                  //* Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext) => LoginView(data: formData ,)) );

                  //Navigator; //.push(context, MaterialPageRoute(builder: (_) => LoginView(data: formData ,)) );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi Pendaftaran'),
                        content: Text('Apakah Anda yakin ingin mendaftar?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Ya'),
                            onPressed: () {
                              //*Push data jika memilih 'Ya'
                              Navigator.push(context, MaterialPageRoute(builder: (_) => LoginView(data: formData)));
                            },
                          ),
                          TextButton(
                            child: Text('Batal'),
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
    );
  }
}