import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scootery/model/maps_model.dart';

class TextWithIconButton extends StatelessWidget {
  final String text;
  final IconData icon;

  TextWithIconButton({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    final _mapPosition = context.select((MapsModel m) => m.mapPosition);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Color(0xFF253759),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              text,
              style: TextStyle(color: Color(0xFF253759), fontSize: 16),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          primary: Colors.white,
        ),
      ),
    );
  }
}
