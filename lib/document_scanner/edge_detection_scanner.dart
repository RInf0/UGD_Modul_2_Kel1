import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class EdgeDetectionScanner extends StatefulWidget {
  EdgeDetectionScanner({super.key, this.encoded});

  String? encoded;

  @override
  EdgeDetectionScannerState createState() => EdgeDetectionScannerState();
}

class EdgeDetectionScannerState extends State<EdgeDetectionScanner> {
  String? _imagePath;
  String? _enc;
  Image? _dec;

  // Image? _uploadedFileImage;

  final Base64Codec base64Codec = const Base64Codec();

  String encodeToBase64(String imagePath) {
    Uint8List imageBytes = File(imagePath).readAsBytesSync();
    String encoded = base64.encode(imageBytes);

    return encoded;
  }

  Image decodeFromBase64(String imgBase64String) {
    Uint8List decoded = base64.decode(imgBase64String);
    return Image.memory(decoded);
  }

  // GETTERS
  String getEncBase64Image() {
    return _enc!;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageFromCamera() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

    // Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    bool success = false;

    try {
      //Make sure to await the call to detectEdge.
      success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      print("success: $success");
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (success) {
        _imagePath = imagePath;
        // _uploadedFileImage = Image.file(File(_imagePath ?? ''));

        _enc = encodeToBase64(_imagePath!);
        widget.encoded = _enc;

        print(_enc);

        _dec = decodeFromBase64(_enc!);
      }
    });
  }

  Future<void> getImageFromGallery() async {
    // Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    bool success = false;
    try {
      //Make sure to await the call to detectEdgeFromGallery.
      success = await EdgeDetection.detectEdgeFromGallery(
        imagePath,
        androidCropTitle: 'Crop', // use custom localizations for android
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      print("success: $success");
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (success) {
        _imagePath = imagePath;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: getImageFromCamera,
              child: const FaIcon(FontAwesomeIcons.camera),
            ),
          ),
          const SizedBox(height: 20),

          // Padding(
          //   padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          //   child: Text(
          //     _imagePath.toString(),
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(fontSize: 14),
          //   ),
          // ),
          Visibility(
            visible: _imagePath != null,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // child: _uploadedFileImage,
                  child: Text('Hasil Scan Dokumen:'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  // child: _uploadedFileImage,
                  child: _dec,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
