import 'package:flutter/material.dart';
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
    DaftarPeriksaView(), //* Jika Error di comment dulu aja
    //* index 2
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                key: Key('bottom_navbar_home'),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                key: Key('bottom_navbar_daftar_periksa'),
              ),
              label: 'Daftar Periksa'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                key: Key('bottom_navbar_profile'),
              ),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        //* parameter : yang menampung index dari menu bottomNav
        onTap: _onItemTapped,
        //* menjalankan fungsi _onItemTapped, yang dimana fungsi ini akan mengubah nilai index dan melakukan setState sesuai index
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
