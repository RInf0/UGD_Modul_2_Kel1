import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class TentangKamiView extends StatefulWidget {
  const TentangKamiView({super.key});

  @override
  State<TentangKamiView> createState() => TentangKamiViewState();
}

class TentangKamiViewState extends State<TentangKamiView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Kami',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: cAccentColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang di Aplikasi Resmi Atma Hospital!',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Aplikasi ini adalah solusi terkini kami untuk meningkatkan akses dan pengalaman Anda dalam merawat kesehatan. Kami berkomitmen untuk memberikan layanan yang lebih baik dan lebih mudah diakses melalui platform digital.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Komitmen Kami:',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Aplikasi Atma Hospital adalah wujud komitmen kami untuk memberikan pelayanan kesehatan yang lebih modern, mudah diakses, dan disesuaikan dengan kebutuhan individu Anda. Kami berharap aplikasi ini tidak hanya mempermudah pengelolaan perawatan kesehatan Anda tetapi juga meningkatkan kualitas hidup Anda secara keseluruhan.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Terima kasih telah memilih Aplikasi Resmi Atma Hospital. Kami berharap Anda merasakan manfaat yang besar dari penggunaan aplikasi ini untuk kesehatan dan kesejahteraan Anda.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Salam Sehat,',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tim Atma Hospital',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
