import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/client/dokter_client.dart';
import 'package:ugd_modul_2_kel1/entity/dokter.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfilDokterView extends StatefulWidget {
  const ProfilDokterView({super.key, required this.dokter});

  final Dokter dokter;

  @override
  State<ProfilDokterView> createState() => _ProfilDokterViewState();
}

class _ProfilDokterViewState extends State<ProfilDokterView> {
  late Dokter dokter;

  void refresh() async {
    final dataDokter = await DokterClient.find(widget.dokter.id);

    // await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      dokter = dataDokter;
    });
  }

  @override
  void initState() {
    dokter = widget.dokter;
    super.initState();
  }

  Table tabelJadwal() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(7),
                color: cAccentColor,
                child: const Text(
                  'Hari',
                  style: cTextStyle6,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(7),
                color: cAccentColor,
                child: const Text(
                  'Jam',
                  style: cTextStyle6,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Senin',
                  style: cTextStyleNormal,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  '08.00 - 12.00',
                  style: cTextStyleNormal,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Selasa',
                  style: cTextStyleNormal,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  '16.00 - 18.30',
                  style: cTextStyleNormal,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Kamis',
                  style: cTextStyleNormal,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  '10.00 - 14.00',
                  style: cTextStyleNormal,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Sabtu',
                  style: cTextStyleNormal,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  '18.45 - 21.00',
                  style: cTextStyleNormal,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cAccentColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Profil Dokter',
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: AssetImage(
                          // 'image/dokter/${Random().nextInt(3)}.jpg',
                          'image/dokter/${dokter.id! % 5}.jpg',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${dokter.nama}',
                              style: cTextStyle12,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Spesialisasi:',
                              style: cTextStyleNormal,
                            ),
                            Text(
                              dokter.job!,
                              style: cTextStyle2Lite,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            const Text(
                              'No. Telepon:',
                              style: cTextStyleNormal,
                            ),
                            Text(
                              dokter.noTelp!,
                              style: cTextStyle2Lite,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  tabelJadwal(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
