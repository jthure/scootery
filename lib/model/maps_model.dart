import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MapsModel extends ChangeNotifier with DiagnosticableTreeMixin  {
  final _location = new Location();
  LocationData? _locationData;
  LocationData? get locationData => _locationData;

  MapPosition? _mapPosition;
  MapPosition? get mapPosition => _mapPosition;

  MapsModel(){
    init();
    _location.onLocationChanged.listen((LocationData locationData) {
      this._locationData = locationData;
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
    this._locationData = await _location.getLocation();
    notifyListeners();

  }

  void updateMapPosition(double latitude, double longitude){
    _mapPosition = new MapPosition(latitude: latitude, longitude: longitude);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // list all the properties of your class here.
    // See the documentation of debugFillProperties for more information.
    properties.add(DoubleProperty('Location latitude', locationData?.latitude));
    properties.add(DoubleProperty('Location longitude', locationData?.longitude));
    properties.add(DoubleProperty('Map camera latetude', mapPosition?.latitude));
    properties.add(DoubleProperty('Map camera longitude', mapPosition?.longitude));
  }
}
class MapPosition{
  final double latitude;
  final double longitude;
  MapPosition({required this.latitude, required this.longitude});
}
