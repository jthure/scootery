import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scootery/model/maps_model.dart';
import 'package:scootery/model/scooters_model.dart';

class MapsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapsWidget();
}

class _MapsWidget extends State {
  Completer<GoogleMapController> _controller = Completer();
  var currentCameraPosition = LatLng(37.42796133580664, -122.085749655962);

  @override
  Widget build(BuildContext context) {
    // _controller.future.then((value) => value.)
    // var _currentLocationData = context.watch<MapsModel>();
    // var currentLocationData = _currentLocationData.locationData;

    // _controller.future.then((value) => value.animateCamera(CameraUpdate.));
    // if(currentLocationData != null){
    //   lat = currentLocationData.latitude;
    //   lng = currentLocationData.longitude;
    // }

    final locationData = context.watch<MapsModel>().locationData;
    final scooters = context.watch<ScooterModel>().items;

    if (locationData != null) {
      final newLatLng = LatLng(locationData.latitude!, locationData.longitude!);
      if (newLatLng != currentCameraPosition) {
        print(currentCameraPosition);
        print(newLatLng);
        _controller.future.then(
            (value) => value.animateCamera(CameraUpdate.newLatLng(newLatLng)));
        this.currentCameraPosition = newLatLng;
      }
    }

    final CameraPosition _kGooglePlex = CameraPosition(
      target: currentCameraPosition,
      zoom: 14.4746,
    );

    return new Scaffold(
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      onTap: (x) => context.read<ScooterModel>().resetSelectedScooter(),
      onCameraMove: (x) => context
          .read<MapsModel>()
          .updateMapPosition(x.target.latitude, x.target.longitude),
      markers: scooters
          .map((e) => Marker(
              icon: e.icon,
              markerId: MarkerId(e.id),
              position: LatLng(e.lat, e.lng),
              infoWindow: InfoWindow(title: e.id),
              consumeTapEvents: true,
              onTap: () => context.read<ScooterModel>().selectScooter(e.id)))
          .toSet(),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ));
  }
}
