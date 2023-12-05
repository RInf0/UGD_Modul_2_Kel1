import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/input_janji_periksa.dart';
import 'package:ugd_modul_2_kel1/view/home/grid.dart';
import 'package:ugd_modul_2_kel1/view/lokasi_rs/lokasi_rs.dart';
import 'package:ugd_modul_2_kel1/View/home/card.dart';
import 'package:ugd_modul_2_kel1/View/home/gridButton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({Key? key}) : super(key: key);

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  //pageController
  final _controller = PageController();

  //fungsi buat pindah page
  void navigateToPage(String pageName) {
    Widget destinationWidget;

    switch (pageName) {
      case 'Janji Periksa':
        destinationWidget = CreateJanjiPeriksaView(janjiPeriksa: null);
        break;
      // case 'Cari Dokter':
      //   break;
      // case 'Pesan Kamar':
      //   break;
      case 'Lokasi':
        destinationWidget = GeoLocationPage();
        break;
      default:
        destinationWidget = Container();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationWidget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          //app bar
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/icons/logosm.jpg'),
                Text(
                  'ATMA',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' HOSPITAL',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 20.sp),

          //cards
          Container(
            height: 250,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: [
                MyCard(color: Colors.green),
                MyCard(color: Colors.blue),
                MyCard(color: Colors.purple),
                MyCard(color: Colors.yellow),
              ],
            ),
          ),
          SizedBox(height: 10.sp),
          SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: ColorTransitionEffect(activeDotColor: Colors.green),
          ),

          //button
          SizedBox(height: 25.sp),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => navigateToPage('Janji Periksa'),
                  child: GridButton(
                      icon: 'lib/icons/schedule.png',
                      textButton: 'Janji Periksa'),
                ),
                GridButton(
                    icon: 'lib/icons/doctor.png', textButton: 'Cari Dokter'),
                GridButton(
                    icon: 'lib/icons/bed.png', textButton: 'Pesan Kamar'),
              ],
            ),
          ),

          SizedBox(height: 15.sp),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => navigateToPage('Lokasi'),
                  child: GridButton(
                      icon: 'lib/icons/map.png', textButton: 'Lokasi RS'),
                ),
                GridButton(icon: 'lib/icons/contact.png', textButton: 'Kontak'),
                GridButton(
                    icon: 'lib/icons/group.png', textButton: 'Tentang Kami'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
