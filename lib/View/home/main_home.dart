import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
import 'package:ugd_modul_2_kel1/view/daftar_periksa/input_janji_periksa.dart';
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

  final listPages = const [
    MyCard(color: Colors.green),
    MyCard(color: Colors.blue),
    MyCard(color: Colors.purple),
    MyCard(color: Colors.yellow),
  ];

  //fungsi buat pindah page
  void navigateToPage(String pageName) {
    Widget destinationWidget;

    switch (pageName) {
      case 'Janji Periksa':
        destinationWidget = const CreateJanjiPeriksaView(janjiPeriksa: null);
        break;
      // case 'Cari Dokter':
      //   break;
      // case 'Pesan Kamar':
      //   break;
      case 'Lokasi':
        destinationWidget = const GeoLocationPage();
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
        child: ListView(
          children: [
            Column(children: [
              //app bar
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'image/logo/logo-atma-hospital.png',
                      height: 25.sp,
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Text(
                      'ATMA',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' HOSPITAL',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: cAccentColor,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 15.sp),

              //cards
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    // agar saat dislide bisa loop slide
                    return listPages[index % listPages.length];
                  },
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                ),
              ),
              SizedBox(height: 15.sp),
              SmoothPageIndicator(
                controller: _controller,
                count: 4,
                // effect: ColorTransitionEffect(activeDotColor: Colors.green),
                effect: ExpandingDotsEffect(
                  activeDotColor: cAccentColor,
                  dotColor: cAccentColor.withOpacity(0.4),
                  dotHeight: 10,
                  dotWidth: 10,
                ),
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
                      child: const GridButton(
                          icon: 'lib/icons/schedule.png',
                          textButton: 'Janji Periksa'),
                    ),
                    const GridButton(
                        icon: 'lib/icons/doctor.png',
                        textButton: 'Cari Dokter'),
                    const GridButton(
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
                      child: const GridButton(
                          icon: 'lib/icons/map.png', textButton: 'Lokasi RS'),
                    ),
                    const GridButton(
                        icon: 'lib/icons/contact.png', textButton: 'Kontak'),
                    const GridButton(
                        icon: 'lib/icons/group.png',
                        textButton: 'Tentang Kami'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
