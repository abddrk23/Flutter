import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:rhino_pizzeria_challenge/values.dart';

class GoogleMap extends StatelessWidget {
  const GoogleMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Google Maps'),
      ),
      body: map.GoogleMap(
        initialCameraPosition: const map.CameraPosition(
          target: map.LatLng(currentLat, currentLng),
          zoom: 18,
        ),
        markers: {
          const map.Marker(
            markerId: map.MarkerId('1'),
            position: map.LatLng(currentLat, currentLng),
          ),
        },
        mapType: map.MapType.normal,
      ),
    );
  }
}
