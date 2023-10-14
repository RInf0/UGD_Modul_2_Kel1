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
  List<Map<String, dynamic>> employee = [];

  void refresh() async {
    final data = await SQLHelper.getUser();
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');

    // Filter data user berdasarkan username yang tersimpan di SharedPreferences
    final userData = data.where((user) => user['username'] == storedUsername).toList();

    setState(() {
      employee = userData;
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
        itemCount: employee.length,
        itemBuilder: (context, index) {
          return Slidable(
            child: Container(
              padding: const EdgeInsets.all(16.0), 
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 242, 242, 242), 
              ),
            child: ListTile(
              title: Text("Username         : " + employee[index]['username'] + "\n" + 
                          "Email                  : " + employee[index]['email'] + "\n" + 
                          "Tanggal Lahir   : " + employee[index]['tgl_lahir'] + "\n" + 
                          "Nomor Telepon: " + employee[index]['no_telp']),
            ),
            ),
            actionPane: SlidableDrawerActionPane(),
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
                        id: employee[index]['id'],
                        username: employee[index]['username'],
                        email: employee[index]['email'],
                        password: employee[index]['password'],
                        tgl_lahir: employee[index]['tgl_lahir'],
                        no_telp: employee[index]['no_telp'],
                      ),
                    ),
                  ).then((_) => refresh());
                },
              ),
            ],
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
