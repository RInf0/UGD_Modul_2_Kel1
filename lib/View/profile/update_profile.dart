import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ugd_modul_2_kel1/client/user_client.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
import 'package:ugd_modul_2_kel1/view/home/home.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:ugd_modul_2_kel1/view/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({
    super.key,
    required this.id,
    required this.username,
    // required this.password,
    required this.email,
    required this.tglLahir,
    required this.noTelp,
  });

  final String? username, email, tglLahir, noTelp;
  final int? id;

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  String _selectedImage = '';
  bool hasProfileImageFromDb = false;
  bool hasUploadedNewImage = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();

  bool passwordInvisible = true;
  bool isEditable = false;
  bool? isChecked = false;
  String selectedGender = '';

  int? idUser;

  setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  final Base64Codec base64Codec = const Base64Codec();

  String encodeToBase64(String imagePath) {
    Uint8List imageBytes = File(imagePath).readAsBytesSync();
    String encoded = base64.encode(imageBytes);
    return encoded;
  }

  MemoryImage decodeFromBase64(String imgBase64String) {
    Uint8List decoded = base64.decode(imgBase64String);
    return MemoryImage(decoded);
  }

  List<Map<String, dynamic>> userProfile = [];

  Future<void> refresh() async {
    // final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    // final storedUsername = prefs.getString('username');
    final storedId = prefs.getInt('id');
    idUser = storedId;

    User user = await UserClient.find(idUser);

    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    // final userData =
    //     data.where((user) => user['username'] == storedUsername).toList();

    if (user.profilePhoto == null) {
      print(
          'Hahahhhhhhhhhhhhhaaaaaaaaaaaaaaa921093102318301312801830222222222222222');
    }

    if (user.profilePhoto != null) {
      hasProfileImageFromDb = true;
      _selectedImage = user.profilePhoto!;
    }
    setState(() {
      // userProfile = userData;

      usernameController.text = widget.username!;
      emailController.text = widget.email!;
      tglLahirController.text = widget.tglLahir!;
      noTelpController.text = widget.noTelp!;
    });

    // refreshProfileImage();
  }

  // Future<void> refreshProfileImage() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? savedImagePath = preferences.getString('imageProfilePath');
  //   print('===================AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA123');

  //   print(hasProfileImageFromDb);

  //   if (savedImagePath != '' && savedImagePath!.isNotEmpty) {
  //     setState(() {
  //       _selectedImage = savedImagePath;
  //     });
  //   } else {
  //     _selectedImage = '';
  //   }
  //   // jika hasProfileImageFromDb true, _selectedImage akan tetap dari Db (didapat dari fungsi refresh())

  //   // print('IMAGE222222 SEELEECTEEDDD ' + _selectedImage);
  // }

  @override
  void initState() {
    super.initState();
    refresh();
    // _selectedImage = '';
  }

  Future<void> _pickImageFromCamera(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final returnedImage = await imagePicker.pickImage(source: source);

    if (returnedImage != null) {
      // _selectedImage = returnedImage.path;
      // // encode dari File ke base64
      // final imgFile = File(_selectedImage);
      // final bytes = imgFile.readAsBytesSync();
      // final base64Img = base64.encode(bytes);
      setState(() {
        hasUploadedNewImage = true;
        _selectedImage = returnedImage.path;
        // _selectedImage = base64Img;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('imageProfilePath', _selectedImage);

      int? userId = preferences.getInt('id');
      if (userId != null) {
        // await SQLHelper.editData(widget.id, {'profile_photo': _selectedImage});
      }
    }
  }

  Future<void> _pickImageFromGallery(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);

    if (returnedImage != null) {
      // _selectedImage = returnedImage.path;
      // // encode dari File ke base64
      // final imgFile = File(_selectedImage);
      // final bytes = imgFile.readAsBytesSync();
      // final base64Img = base64.encode(bytes);
      setState(() {
        hasUploadedNewImage = true;
        _selectedImage = returnedImage.path;
        // _selectedImage = base64Img;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('profileImagePath', _selectedImage);

      int? userId = preferences.getInt('id');
      if (userId != null) {
        // await SQLHelper.editData(widget.id, {'profile_photo': _selectedImage});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // if(widget.id != null){
    //   usernameController.text = widget.username!;
    //   emailController.text = widget.email!;
    //   passwordController.text = widget.password!;
    //   tglLahirController.text = widget.tglLahir!;
    //   noTelpController.text =widget.noTelp!;
    // }
    return Scaffold(
      appBar: AppBar(),
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

                  // Image Profile
                  imageProfile(),

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
                  // Field password tidak dipakai krn udah ada reset password page
                  // Untuk kepentingan security juga
                  //
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 20, top: 10, right: 20),
                  //   child: TextFormField(
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return "Password tidak boleh kosong";
                  //       }
                  //       if (value.length < 5) {
                  //         return 'Password minimal 5 karakter';
                  //       }
                  //       return null;
                  //     },
                  //     obscureText: passwordInvisible,
                  //     controller: passwordController,
                  //     decoration: InputDecoration(
                  //       labelText: "Password",
                  //       prefixIcon: const Icon(Icons.lock),
                  //       suffixIcon: IconButton(
                  //         icon: Icon(passwordInvisible
                  //             ? Icons.visibility_off
                  //             : Icons.visibility),
                  //         onPressed: () {
                  //           setState(
                  //             () {
                  //               passwordInvisible = !passwordInvisible;
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
                            // Map<String, dynamic> formData = {};
                            // formData['username'] = usernameController.text;
                            // formData['password'] = passwordController.text;

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
                                        //*Push data jika memilih 'Ya'
                                        await editUserProfile(widget.id!);
                                        // Kemudian kembali ke halaman profil atau tindakan lain sesuai kebutuhan aplikasi Anda.
                                        if (!context.mounted) return;
                                        // pop yes/no dialog
                                        Navigator.of(context).pop();

                                        // pop update_profile view
                                        Navigator.of(context).pop();
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

  Widget imageProfile() {
    // print('IMAGE ===========================' + _selectedImage);
    return Center(
      child: Stack(children: <Widget>[
        Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _selectedImage != '' && hasUploadedNewImage
                  ? FileImage(File(_selectedImage))
                  : _selectedImage != '' && hasProfileImageFromDb
                      ? NetworkImage(_selectedImage)
                      : const AssetImage('image/random.png')
                          as ImageProvider<Object>,
            ),
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  _pickImageFromCamera(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  _pickImageFromGallery(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> editUserProfile(int id) async {
    // await SQLHelper.editUser(id, usernameController.text, emailController.text,
    //     tglLahirController.text, noTelpController.text, _selectedImage);

    // nanti decode ke <ImageProvider> MemoryImage

    var base64Img = '';

    // jika ada perubahan
    if (hasUploadedNewImage) {
      // encode dari File ke base64
      final imgFile = File(_selectedImage);
      final bytes = imgFile.readAsBytesSync();
      base64Img = base64.encode(bytes);
    }

    await UserClient.update(
      User(
        id: idUser,
        username: usernameController.text,
        email: emailController.text,
        tglLahir: tglLahirController.text,
        noTelp: noTelpController.text,
        // profilePhoto: _selectedImage,
        profilePhoto: base64Img,
      ),
    );

    // Setelah mengedit data, Anda dapat menyimpan data yang baru dalam SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);
  }
}
