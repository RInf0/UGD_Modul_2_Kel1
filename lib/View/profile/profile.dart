import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/View/home/home.dart';
import 'package:ugd_modul_2_kel1/View/login/reset_password.dart';
import 'package:ugd_modul_2_kel1/View/profile/update_profile.dart';
import 'package:ugd_modul_2_kel1/client/user_client.dart';
// import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/main.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
import 'package:ugd_modul_2_kel1/view/login/login.dart';

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
      // password = dataUser.password!;
      // profilePic =

      if (dataUser.profilePhoto != null) {
        profilePic = dataUser.profilePhoto!;
      }
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Widget buildProfileCoverTop({double? height}) {
    return Container(
      clipBehavior: Clip.none,
      height: height ?? 200.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.green,
        ),
      ),
    );
  }

  Widget buildCircleAvatar({double? radius}) {
    return CircleAvatar(
      radius: radius ?? 60.0,
      backgroundImage: profilePic != null
          // ? MemoryImage(base64Decode(profilePic!))
          ? NetworkImage(profilePic!)
          : const AssetImage('image/random.png') as ImageProvider<Object>,
    );
  }

  Widget buildProfileContentInside({double? spacerHeight}) {
    return Column(
      children: [
        // untuk spacer antara circle avatar dan text dibawahnya
        // relatif menyesuaikan radius circle avatar
        SizedBox(
          height: (spacerHeight ?? 60.0) + 15.0,
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
          height: 20,
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
        ),
        cSizedBox2,
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Akun',
                    style: cTextStyle2,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Colors.grey.shade400))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: ListTile(
                    leading: const FaIcon(FontAwesomeIcons.solidUser),
                    trailing: const Icon(Icons.chevron_right),
                    title: const Text('Edit Profile'),
                    onTap: () async {
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
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Colors.grey.shade400))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: ListTile(
                    leading: const FaIcon(FontAwesomeIcons.unlock),
                    trailing: const Icon(Icons.chevron_right),
                    title: const Text('Ganti Password'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordView(),
                          ));
                    },
                  ),
                ),
              ),
            ),
            cSizedBox2,
            cSizedBox2,
          ],
        ),
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Keluar',
                    style: cTextStyle2,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Colors.grey.shade400))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: ListTile(
                    iconColor: const Color.fromARGB(255, 196, 5, 5),
                    titleTextStyle: TextStyle(
                        color: const Color.fromARGB(255, 196, 5, 5),
                        fontSize: 16.sp),
                    leading:
                        const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                    trailing: const Icon(Icons.chevron_right),
                    title: const Text('Log Out'),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                          (route) => false);
                    },
                  ),
                ),
              ),
            ),
            cSizedBox2,
            cSizedBox2,
          ],
        ),
        // Container(
        //   height: 10,
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade300,
        //   ),
        // ),
        cSizedBox2,
        cSizedBox2,
        cSizedBox2,
      ],
    );
  }

  Widget buildProfileContent({double? borderRadiusTop}) {
    double circleAvatarRadius = 70.0;

    print(myAppKey.currentState!.getIsDarkTheme());

    return Container(
      constraints: BoxConstraints(minHeight: 85.h),
      width: double.infinity,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadiusTop ?? 25.0),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Stack 1
          buildProfileContentInside(spacerHeight: circleAvatarRadius),

          // Stack 2
          Positioned(
            top: (0 - circleAvatarRadius),
            child: buildCircleAvatar(radius: circleAvatarRadius),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bgCoverHeight = 20.h - 70;
    const borderRadius = 25.0;

    return Scaffold(
      backgroundColor: cAccentColor,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: bgCoverHeight),
            buildProfileContent(borderRadiusTop: borderRadius),
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
