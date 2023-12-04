import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/input_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/view/home/grid.dart';
import 'package:ugd_modul_2_kel1/view/lokasi_rs/lokasi_rs.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({Key? key}) : super(key: key);

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  'Rumah Sakit',
                  style: TextStyle(fontSize: 17.sp),
                ),
                SizedBox(
                  height: 6.h,
                  width: 70.w,
                  child: ElevatedButton(
                    key: const Key('button_buat_janji_periksa'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateJanjiPeriksaView(
                            janjiPeriksa: null,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Buat Janji Periksa',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  ),
                ),
                SizedBox(height: 2.h), 
                SizedBox(
                  height: 6.h,
                  width: 70.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GeoLocationPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Jarak Rumah Sakit',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  ),
                ),
                SizedBox(height: 2.h), 
                MyGrid(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
