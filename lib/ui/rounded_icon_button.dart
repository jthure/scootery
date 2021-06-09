import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scootery/model/maps_model.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;

  RoundedIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    final _mapPosition = context.select((MapsModel m) => m.mapPosition);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(
          icon,
          color: Color(0xFF253759),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: const EdgeInsets.all(8.0),
          primary: Colors.white,
        ),
      ),
    );
  }
}
