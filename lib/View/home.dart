import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/View/view_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  //* selectedIndex berkaitan dengan index halaman paad bottomNavigasi
  int _selectedIndex = 0;
  //* fungsi yang nantinya akan dijalankan setiap menekan menu pada navbar
  void _onItemTapped(int index) {
    //* setState berkaitan dengan fungsi untuk menampilkan perubahan kondisi & dalam banyak kasus akan menggunakan ini\
    setState(() {
      _selectedIndex = index;
    });
  }

  //* Menampung List Widget yang akan ditampilkan sesuai index yang dipilih
  static const List<Widget> _widgetOptions = <Widget>[
    
    //* index 0
    Center(
      child: Image(image: NetworkImage('https://picsum.photos/200/300'))
    ),
    //* index 1
    ListNamaView(), //* Jika Error di comment dulu aja
    //* index 2
    Center(
      child: Text(
        'Index 3: Profile'
      ),
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* setting navigasi bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list,),label: 'list'),
          BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'Profile}'),
        ],
        currentIndex: _selectedIndex, //* parameter : yang menampung index dari menu bottomNav
        onTap: _onItemTapped, //* menjalankan fungsi _onItemTapped, yang dimana fungsi ini akan mengubah nilai index dan melakukan setState sesuai index
      ),
      //* bagian body dari home berdasarkan List _widgetOption berdasarkan index selectedIndex
      body: _widgetOptions.elementAt(_selectedIndex), //* Mengubah tampilan widget sesuai nilai selectedIndex
    );
  }
}