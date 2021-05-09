import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scootery/model/maps_model.dart';
import 'package:scootery/model/scooters_model.dart';

class FloatingRefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mapPosition = context.select((MapsModel m) => m.mapPosition);

    return FloatingActionButton(
      onPressed: () => {
        if (_mapPosition != null)
          {
            context
                .read<ScooterModel>()
                .fetchScooters(_mapPosition.latitude, _mapPosition.longitude)
          }
      },
      child: Icon(Icons.refresh),
    );
  }
}
