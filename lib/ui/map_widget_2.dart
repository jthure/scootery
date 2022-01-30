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
  var currentCameraPosition = LatLng(47.42796133580664, -122.085749655962);

  MapController mapController = MapController();
  UserLocationOptions? userLocationOptions;
  List<Marker> markers = [];


  @override
  void initState() {
    super.initState();

    // mapController.mapEventStream.listen((MapEvent event) => {
    //   //print("Event source: ${event.source}")
    // });
  }

  @override
  Widget build(BuildContext context) {

    final m = context.read<MapsModel>();
    final scooters = context.watch<ScooterModel>().items;

    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      zoomToCurrentLocationOnLoad: true,
      updateMapLocationOnPositionChange: false,
      showHeading: true,
    );




    var scooterMarkers = scooters.map((e) => Marker(
      width: 30.0,
      height: 30.0,
      point: LatLng(e.lat, e.lng),
      builder: (ctx) =>
          Container(
            child: e.icon,
          ),
    )).toList();


    return FlutterMap(
      options: MapOptions(
        center: currentCameraPosition,
        zoom: 13.0,
        onPositionChanged: (MapPosition pos, x) => {m.updateMapPosition(pos.center.latitude, pos.center.longitude)},
        plugins: [
          UserLocationPlugin()
        ],
      ),
      mapController: mapController,
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            // urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: scooterMarkers,
        ),
        MarkerLayerOptions(markers: markers),
        userLocationOptions!,
      ],
    );
  }
}
