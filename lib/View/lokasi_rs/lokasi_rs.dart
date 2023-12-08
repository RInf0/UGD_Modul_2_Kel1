import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocationPage extends StatefulWidget {
  const GeoLocationPage({Key? key}) : super(key: key);

  @override
  State<GeoLocationPage> createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocationPage> {
  Position? _currentLoc;
  late bool servicePermission = false;
  late LocationPermission permission;

  final List<LatLng> _hospitalLocations = [
    const LatLng(-7.776669081142168, 110.37664490640475), // Rumah Sakit Panti Rapih
    const LatLng(-7.768017006162372, 110.3730437530755), // Rumah Sakit Dr. Sardjito
    const LatLng(-7.77079110728325, 110.41583261074847), // Rumah Sakit Sadewa
  ];

  String _currentAddress = "";
  Map<String, double> _distanceToHospitals = {};
  String _nearestHospital = "";

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
      _currentLoc!.latitude, _currentLoc!.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });

      _distanceToHospitals.clear();
      double minDistance = double.infinity;
      for (int i = 0; i < _hospitalLocations.length; i++) {
        double distanceInMeters = Geolocator.distanceBetween(
          _currentLoc!.latitude,
          _currentLoc!.longitude,
          _hospitalLocations[i].latitude,
          _hospitalLocations[i].longitude,
        );

        _distanceToHospitals["Rumah Sakit ${i + 1}"] = distanceInMeters / 1000;

        if (distanceInMeters < minDistance) {
          minDistance = distanceInMeters;
          _nearestHospital = 'Rumah Sakit ${i + 1}';
        }
      }

      double distanceInKilometers = minDistance / 1000;
      setState(() {
        _distanceToHospitals["Terdekat"] = distanceInKilometers;
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
            Column(
              children: _distanceToHospitals.entries.map((entry) {
                return Text("${entry.key}: ${entry.value} kilometer");
              }).toList(),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Rumah Sakit Terdekat:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_nearestHospital),
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
