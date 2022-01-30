import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scootery/model/maps_model.dart';
import 'package:scootery/model/scooter.dart';
import 'package:scootery/model/scooters_model.dart';
import 'package:scootery/ui/text_with_icon_button.dart';

class FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mapPosition = context.select((MapsModel m) => m.mapPosition);
    final scooterModel = context.read<ScooterModel>();
    final onCLick = () {
      scooterModel.fetchScooters(_mapPosition.latitude, _mapPosition.longitude);
    };
    return TextWithIconButton(
      text: "Filter",
      icon: Icons.filter,
      onCLick: onCLick,
    );
  }
}
