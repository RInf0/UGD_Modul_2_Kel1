import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationPage extends StatefulWidget {
  const GeoLocationPage({super.key});

  @override
  State<GeoLocationPage> createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocationPage> {
  Position? _currentLoc;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = "";
  double _distanceToLocation = 0.0; // Menyimpan jarak ke lokasi

  Future<Position?> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service Disabled");
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressLocation() async {
    await placemarkFromCoordinates(
            _currentLoc!.latitude, _currentLoc!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
      // Hitung jarak ke lokasi Jl. Babarsari No.43(Rumah Sakit)
      double distanceInMeters = Geolocator.distanceBetween(
          _currentLoc!.latitude, _currentLoc!.longitude, -7.7753, 110.3899);
      double distanceInKilometers = distanceInMeters / 1000;
      setState(() {
        _distanceToLocation = distanceInKilometers;
      });
    }).catchError((e) {
      print("Error : $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jarak Rumah Sakit',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Lokasi Anda Berada di:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(_currentAddress),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Jarak ke Rumah Sakit:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("$_distanceToLocation kilometer"),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                _currentLoc = await _getCurrentLocation();
                if (_currentLoc != null) {
                  await _getAddressLocation();
                  print(_currentLoc);
                  print(_currentAddress);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.location_pin),
                  SizedBox(width: 8),
                  Text('Jarak Saya ke Rumah Sakit'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
