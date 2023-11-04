import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
import 'package:ugd_modul_2_kel1/view/profile/update_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? userProfile;
  String username = '', email = '', noTelp = '';

  void refresh() async {
    final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');

    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    setState(() {
      final userData =
          data.where((user) => user['username'] == storedUsername).toList();

      userProfile = userData[0];
      username = userProfile!['username'];
      email = userProfile!['email'];
      noTelp = userProfile!['no_telp'];
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
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('image/icon/1.png'),
                ),
                Text(
                  username,
                  style: cTextStyle1,
                ),
                cSizedBox2,
                Text(email),
                Text(noTelp),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateView(
                          id: userProfile!['id'],
                          username: userProfile!['username'],
                          email: userProfile!['email'],
                          password: userProfile!['password'],
                          tglLahir: userProfile!['tgl_lahir'],
                          noTelp: userProfile!['no_telp'],
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