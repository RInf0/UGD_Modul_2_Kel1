import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ugd_modul_2_kel1/entity/janji_periksa.dart';
import 'package:ugd_modul_2_kel1/entity/user.dart';
// import 'package:ugd_modul_2_kel1/pdf/invoice/model/custom_row_invoice.dart';
import 'package:ugd_modul_2_kel1/pdf/preview_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';
import 'package:uuid/uuid.dart';

String randomUuid() {
  var uuid = const Uuid();
  return uuid.v4();
}

Future<void> createPdf(
    BuildContext context, JanjiPeriksa janjiPeriksa, User pasien) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  // final imageLogo =
  //     (await rootBundle.load("assets/logo.png")).buffer.asUint8List();
  // final imageInvoice = pw.MemoryImage(imageLogo);

  pw.ImageProvider pdfImageProvider(Uint8List imageBytes) {
    return pw.MemoryImage(imageBytes);
  }

  // final imageBytes = image.readAsBytesSync();

  final pdfTheme = pw.PageTheme(
    margin: pw.EdgeInsets.zero,
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
          // decoration: pw.BoxDecoration(
          //   border: pw.Border.all(
          //     color: PdfColor.fromHex('#000000'),
          //     width: 1,
          //   ),
          // ),
          );
    },
  );

  // final List<CustomRow> elements = [
  //   CustomRow("Item Name", "Item Price", "Amount", "Sub Total Product"),
  //   CustomRow(
  //     "Sub Total",
  //     "",
  //     "",
  //     "Rp ",
  //   ),
  // ];

  // pw.Widget table = itemColumn(elements);

  doc.addPage(pw.MultiPage(
    pageTheme: pdfTheme,
    header: (pw.Context context) {
      return headerPDF();
    },
    build: (pw.Context context) {
      return [
        pw.Center(
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
              pw.SizedBox(height: 2.h),

              pw.Text(
                'Dokumen Janji Periksa',
                style: pw.TextStyle(
                  fontSize: 18.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 1.h),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'ID Periksa : ${janjiPeriksa.id}',
                    style: pw.TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  pw.Text(
                    '   |   ',
                    style: pw.TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  pw.Text(
                    'Tanggal Periksa : ${janjiPeriksa.tglPeriksa}',
                    style: pw.TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 3.h),

              pw.Text(
                'Data Pasien',
                style: pw.TextStyle(
                  fontSize: 15.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              personalDataFromInput(
                nama: pasien.username!,
                email: pasien.email!,
                noTelp: pasien.noTelp!,
                tglLahir: pasien.tglLahir!,
              ),

              pw.SizedBox(height: 1.h),

              pw.Text(
                'Data Periksa',
                style: pw.TextStyle(
                  fontSize: 15.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              janjiPeriksaDataFromInput(
                namaDokter: janjiPeriksa.namaDokter,
                keluhan: janjiPeriksa.keluhan,
              ),

              pw.Row(
                children: [
                  // pw.Expanded(
                  //   child: pw.Text(
                  //     'Expand A',
                  //     style: pw.TextStyle(
                  //       fontSize: 16.sp,
                  //     ),
                  //     textAlign: pw.TextAlign.center,
                  //   ),
                  // ),
                  // pw.Expanded(
                  //   child: pw.Text(
                  //     'Expand B',
                  //     style: pw.TextStyle(
                  //       fontSize: 16.sp,
                  //     ),
                  //     textAlign: pw.TextAlign.center,
                  //   ),
                  // ),
                ],
              ),

              pw.SizedBox(height: 2.h),

              // topOfInvoice(imageInvoice),
              // BARCODE
              //barcodeGaris(janjiPeriksa.id!),
              // pw.SizedBox(height: 5.h),
              barcodeKotak(),
              pw.Text('Scan QR ini untuk Cetak No. Antrian di Rumah Sakit'),

              pw.SizedBox(height: 1.h),

              if (janjiPeriksa.dokumen != null)
                pw.Column(
                  children: [
                    pw.SizedBox(height: 2.h),

                    pw.Text(
                      'Foto Dokumen',
                      style: pw.TextStyle(
                        fontSize: 15.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    // image from input
                    imageFromInput(
                      pdfImageProvider,
                      const Base64Decoder().convert(janjiPeriksa.dokumen!),
                    ),
                  ],
                ),

              // showImageDokumenJanjiPeriksa(janjiPeriksa.dokumen!),
            ])),
      ];
    },
    footer: (pw.Context context) {
      return pw.Container(
        color: PdfColor.fromHex('#0D8F83'),
        child: footerPdf(formattedDate),
      );
    },
  ));
  // ignore: use_build_context_synchronously
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ));
}

pw.Padding showImageDokumenJanjiPeriksa(String fotoDokumen) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(20),
    // child: _uploadedFileImage,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Image(base64StringToImage(fotoDokumen)),
      ],
    ),
  );
}

pw.MemoryImage base64StringToImage(String fotoDokumen) {
  return pw.MemoryImage(
    const Base64Decoder().convert(fotoDokumen),
  );
}

pw.Header headerPDF() {
  return pw.Header(
      margin: pw.EdgeInsets.zero,
      outlineColor: PdfColors.amber50,
      outlineStyle: PdfOutlineStyle.normal,
      level: 5,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.rectangle,
        gradient: pw.LinearGradient(
          colors: [PdfColor.fromHex('#fefefe'), PdfColor.fromHex('#eaeaea')],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
      ),
      child: pw.Center(
        child: pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'ATMA',
                    style: pw.TextStyle(
                      fontSize: 20.sp,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.Text(
                    'HOSPITAL',
                    style: pw.TextStyle(
                      fontSize: 20.sp,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#0D8F83'),
                    ),
                  )
                ],
              ),
              pw.Text(
                'BETTER HEALTH, BETTER LIFE',
                style: pw.TextStyle(
                  fontSize: 13.sp,
                  fontWeight: pw.FontWeight.normal,
                ),
              )
            ])),
      ));
}

pw.Padding imageFromInput(
  pw.ImageProvider Function(Uint8List imageBytes) pdfImageProvider,
  Uint8List imageBytes,
) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
    child: pw.FittedBox(
      child: pw.Image(pdfImageProvider(imageBytes), width: 85.w),
      fit: pw.BoxFit.fitHeight,
      alignment: pw.Alignment.center,
    ),
  );
}

pw.Padding personalDataFromInput(
    {required String nama,
    required String email,
    required String noTelp,
    required String tglLahir}) {
  return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 5.h, vertical: 1.h),
      child: pw.Table(
        // border: pw.TableBorder.all(),
        columnWidths: const {
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(4),
        },
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  'Nama Pasien',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  ' : $nama',
                  style: pw.TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  'Tanggal Lahir',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  ' : $tglLahir',
                  style: pw.TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  'No. Telepon',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  ' : $noTelp',
                  style: pw.TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  'Email',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  ' : $email',
                  style: pw.TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

pw.Padding janjiPeriksaDataFromInput({
  required String namaDokter,
  required String keluhan,
}) {
  return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 5.h, vertical: 1.h),
      child: pw.Table(
        // border: pw.TableBorder.all(),
        columnWidths: const {
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(4),
        },
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  'Nama Dokter',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  ' : $namaDokter',
                  style: pw.TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  'Keluhan',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: pw.Text(
                  ' : $keluhan',
                  style: pw.TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(imageInvoice, height: 30.h, width: 30.w),
        pw.Expanded(
          child: pw.Container(
            height: 10.h,
            decoration: const pw.BoxDecoration(
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                color: PdfColors.amberAccent),
            padding: const pw.EdgeInsets.only(
                left: 40, top: 10, bottom: 10, right: 40),
            alignment: pw.Alignment.centerLeft,
            child: pw.DefaultTextStyle(
              style:
                  const pw.TextStyle(color: PdfColors.amber100, fontSize: 12),
              child: pw.GridView(
                crossAxisCount: 2,
                children: [
                  pw.Text('Awesome Product',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('Anggek Street 12',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Jakarta 5111',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1.h),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Contact Us',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.SizedBox(height: 1.h),
                  pw.Text('Phone Number',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('0812345678',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('Email',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                  pw.Text('awesomeproduct@gmail.com',
                      style: pw.TextStyle(
                          fontSize: 10.sp, color: PdfColors.blue800)),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Padding contentOfInvoice(pw.Widget table) {
  return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Column(children: [
        pw.Text(
            "Dear Customer, thank you for buying our project, we hope the products can make your day."),
        pw.SizedBox(height: 3.h),
        table,
        pw.Text("Thanks for your trust, and till the next time."),
        pw.SizedBox(height: 3.h),
        pw.Text("Kind regards,"),
        pw.SizedBox(height: 3.h),
        pw.Text("1180"),
      ]));
}

pw.Padding barcodeKotak() {
  // final idPer = id.toString();
  String randomId = randomUuid();
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
    child: pw.Center(
      child: pw.Column(
        children: [
          pw.BarcodeWidget(
            barcode: pw.Barcode.qrCode(
              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
            ),
            data: randomId,
            width: 30.w,
            height: 30.h,
          ),
          pw.Text(randomId),
          pw.SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

pw.Container barcodeGaris(int id) {
  final idPer = id.toString();
  return pw.Container(
    child: pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: pw.BarcodeWidget(
        barcode: Barcode.code128(escapes: true),
        data: idPer,
        width: 10.w,
        height: 5.h,
      ),
    ),
  );
}

pw.Center footerPdf(String formattedDate) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style: pw.TextStyle(
          fontSize: 14.sp,
          color: PdfColor.fromHex('#FFFFFF'),
        )));
