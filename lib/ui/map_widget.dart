import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scootery/model/maps_model.dart';
import 'package:provider/provider.dart';

class MapsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    // _controller.future.then((value) => value.)
    var lat = 37.42796133580664;
    var lng = -122.085749655962;
    var _currentLocationData = context.watch<MapsModel>();
    var currentLocationData = _currentLocationData.locationData;
    if(currentLocationData != null){
      lat = currentLocationData.latitude;
      lng = currentLocationData.longitude;
    }

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 14.4746,
    );
    return new Scaffold(
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ));
  }
}
