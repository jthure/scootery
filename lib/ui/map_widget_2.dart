import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:scootery/model/maps_model.dart';
import 'package:scootery/model/scooters_model.dart';
import 'package:latlong/latlong.dart';
import 'package:user_location/user_location.dart';

class MapsWidget2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapsWidget();
}

class _MapsWidget extends State {
  // Completer<GoogleMapController> _controller = Completer();
  var currentCameraPosition = LatLng(47.42796133580664, -122.085749655962);

  MapController mapController = MapController();
  UserLocationOptions? userLocationOptions;
  List<Marker> markers = [];


  @override
  void initState() {
    super.initState();

    mapController.mapEventStream.listen((MapEvent event) => {
      print("Event source: ${event.source}")
    });
  }

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

    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      zoomToCurrentLocationOnLoad: true,

      updateMapLocationOnPositionChange: false,
    );

    final locationData = context.watch<MapsModel>().locationData;
    final scooters = context.watch<ScooterModel>().items;

    if (locationData != null) {
      final newLatLng = LatLng(locationData.latitude!, locationData.longitude!);
      if (newLatLng != currentCameraPosition) {
        print(currentCameraPosition);
        print(newLatLng);
        mapController.move(newLatLng, 13.0);
        this.currentCameraPosition = newLatLng;
      }
    }

    // final CameraPosition _kGooglePlex = CameraPosition(
    //   target: currentCameraPosition,
    //   zoom: 14.4746,
    // );

    return FlutterMap(
      options: MapOptions(
        center: currentCameraPosition,
        zoom: 13.0,
        plugins: [
          UserLocationPlugin()
        ]
      ),
      mapController: mapController,
      layers: [
        TileLayerOptions(
            // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png",
            // subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) =>
                  Container(
                    child: FlutterLogo(),
                  ),
            ),
          ],
        ),
        MarkerLayerOptions(markers: markers),
        userLocationOptions!,
      ],
    );
  }
}
