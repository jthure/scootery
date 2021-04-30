import 'package:google_maps_flutter/google_maps_flutter.dart';

class Scooter {
  final String id;
  final double lat;
  final double lng;
  final String provider;
  final BitmapDescriptor icon;

  Scooter({required this.id, required this.lat, required this.lng, required this.icon, required this.provider});
}
