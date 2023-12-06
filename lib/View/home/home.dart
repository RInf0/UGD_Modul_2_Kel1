import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/daftar_periksa.dart';
import 'package:ugd_modul_2_kel1/view/home/main_home.dart';
import 'package:ugd_modul_2_kel1/view/profile/profile.dart';
import 'package:ugd_modul_2_kel1/main.dart';

bool isDark = myAppKey.currentState!.getIsDarkTheme();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();

  // membuat global key untuk simpan state dari HomeViewState
}

class _HomeViewState extends State<HomeView> {
  //* selectedIndex berkaitan dengan index halaman paad bottomNavigasi
  int _selectedIndex = 0;

  // variabel dark/light(system) theme, ambil dari class utama yaitu MyApp
  Icon _changeThemeButtonIcon = myAppKey.currentState!.getThemeButtonIcon();
  bool _isDarkTheme = myAppKey.currentState!.getIsDarkTheme();

  //* fungsi yang nantinya akan dijalankan setiap menekan menu pada navbar
  void _onItemTapped(int index) {
    //* setState berkaitan dengan fungsi untuk menampilkan perubahan kondisi & dalam banyak kasus akan menggunakan ini\
    setState(() {
      _selectedIndex = index;
    });
  }

  // method untuk mengubah theme, memanggil method dari class utama yaitu MyApp
  void changeTheme(bool isDarkTheme) {
    setState(() {
      myAppKey.currentState?.changeTheme(isDarkTheme);
      _changeThemeButtonIcon = myAppKey.currentState!.getThemeButtonIcon();
    });
  }

  //* Menampung List Widget yang akan ditampilkan sesuai index yang dipilih
  static const List<Widget> _widgetOptions = <Widget>[
    //* index 0
    MainHomeView(),
    //* index 1
    DaftarPeriksaView(),
    //* index 2
    DaftarPeriksaView(),
    //* index 3
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floating button untuk change light/system mode to dark mode dan sebaliknya
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeTheme(_isDarkTheme);
          setState(() {
            _isDarkTheme = !_isDarkTheme;
            isDark = _isDarkTheme;
          });
        },
        child: _changeThemeButtonIcon,
      ),
      //* setting navigasi bar
      bottomNavigationBar: Container(
        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 85,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 211, 211, 211),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 23,
            items: const [
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    key: Key('bottom_navbar_home'),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.calendarCheck,
                    key: Key('bottom_navbar_daftar_periksa'),
                  ),
                  label: 'Periksa'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.bed,
                    key: Key('bottom_navbar_daftar_kamar'),
                  ),
                  label: 'Kamar'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.solidUser,
                    key: Key('bottom_navbar_profile'),
                  ),
                  label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            //* parameter : yang menampung index dari menu bottomNav
            onTap: _onItemTapped,
            //* menjalankan fungsi _onItemTapped, yang dimana fungsi ini akan mengubah nilai index dan melakukan setState sesuai index
          ),
        ),
      ),
      //* bagian body dari home berdasarkan List _widgetOption berdasarkan index selectedIndex
      body: _widgetOptions.elementAt(_selectedIndex),
      //* Mengubah tampilan widget sesuai nilai selectedIndex
      //
      // ),
      //
    );
  }
}
