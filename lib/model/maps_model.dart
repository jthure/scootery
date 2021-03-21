import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MapsModel extends ChangeNotifier {
  final _location = new Location();
  LocationData locationData;
  MapsModel(){
    init();
    _location.onLocationChanged.listen((LocationData locationData) {
      this.locationData = locationData;
      this.notifyListeners();
    });
  }

  void init() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    this.locationData = await _location.getLocation();
    notifyListeners();

  }
  @override
  String toString() {
    var lng = locationData?.longitude;
    var lat = locationData?.latitude;
    return "Lat: $lat, Long: $lng";
  }
}
