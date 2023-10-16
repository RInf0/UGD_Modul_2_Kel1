import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd_modul_2_kel1/database/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_modul_2_kel1/View/update.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> userProfile = [];

  void refresh() async {
    final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');

    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    final userData =
        data.where((user) => user['username'] == storedUsername).toList();

    setState(() {
      userProfile = userData;
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
      body: ListView.builder(
        itemCount: userProfile.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: const SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: 'Update',
                color: Colors.blue,
                icon: Icons.update,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateView(
                        id: userProfile[index]['id'],
                        username: userProfile[index]['username'],
                        email: userProfile[index]['email'],
                        password: userProfile[index]['password'],
                        tglLahir: userProfile[index]['tgl_lahir'],
                        noTelp: userProfile[index]['no_telp'],
                      ),
                    ),
                  ).then((_) => refresh());
                },
              ),
            ],
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 242, 242, 242),
              ),
              child: ListTile(
                title: Text("Username         : " +
                    userProfile[index]['username'] +
                    "\n" +
                    "Email                  : " +
                    userProfile[index]['email'] +
                    "\n" +
                    "Tanggal Lahir   : " +
                    userProfile[index]['tgl_lahir'] +
                    "\n" +
                    "Nomor Telepon: " +
                    userProfile[index]['no_telp']),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> deleteUser(int id) async {
    await SQLHelper.deleteUser(id);
    refresh();
  }
}
