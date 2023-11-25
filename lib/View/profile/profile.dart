import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/View/profile/update_profile.dart';
import 'package:ugd_modul_2_kel1/client/user_client.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? userProfile;
  String username = '', email = '', noTelp = '', tglLahir = '';
  String password = '';
  String? profilePic;

  int? idUser;

  void refresh() async {
    // final data = await SQLHelper.getUser();

    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getInt('id');

    final dataUser = await UserClient.find(storedId);

    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    setState(() {
      // final userData =
      //     data.where((user) => user['username'] == storedUsername).toList();
      // userProfile = userData[0];

      // username = userProfile!['username'];
      // email = userProfile!['email'];
      // noTelp = userProfile!['no_telp'];
      // profilePic = userProfile!['profile_photo'];

      idUser = dataUser.id!;
      username = dataUser.username!;
      email = dataUser.email!;
      noTelp = dataUser.noTelp!;
      tglLahir = dataUser.tglLahir!;
      password = dataUser.password!;
      // profilePic =
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
                cSizedBox2,
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profilePic != null
                      ? FileImage(File(profilePic!))
                      : const AssetImage('image/random.png')
                          as ImageProvider<Object>,
                ),
                Text(
                  username,
                  style: cTextStyle1,
                ),
                cSizedBox2,
                Text(email),
                Text(noTelp),
                Text(tglLahir),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateView(
                          id: idUser,
                          username: username,
                          email: email,
                          tglLahir: tglLahir,
                          noTelp: noTelp,
                        ),
                      ),
                    ).then((_) => refresh());
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// body: ListView.builder(
//   itemCount: userProfile.length,
//   itemBuilder: (context, index) {
//     return Slidable(
//       actionPane: const SlidableDrawerActionPane(),
//       secondaryActions: [
//         IconSlideAction(
//           caption: 'Update',
//           color: Colors.blue,
//           icon: Icons.update,
//           onTap: () async {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => UpdateView(
//                   id: userProfile[index]['id'],
//                   username: userProfile[index]['username'],
//                   email: userProfile[index]['email'],
//                   password: userProfile[index]['password'],
//                   tglLahir: userProfile[index]['tgl_lahir'],
//                   noTelp: userProfile[index]['no_telp'],
//                 ),
//               ),
//             ).then((_) => refresh());
//           },
//         ),
//       ],
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 242, 242, 242),
//         ),
//         child: ListTile(
//           title: Text("Username         : " +
//               userProfile[index]['username'] +
//               "\n" +
//               "Email                  : " +
//               userProfile[index]['email'] +
//               "\n" +
//               "Tanggal Lahir   : " +
//               userProfile[index]['tgl_lahir'] +
//               "\n" +
//               "Nomor Telepon: " +
//               userProfile[index]['no_telp']),
//         ),
//       ),
//     );
//   },
// ),
