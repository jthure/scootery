import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scootery/data/scooter_repo.dart';
import 'package:scootery/model/maps_model.dart';
import 'package:scootery/ui/map_widget_2.dart';
import 'package:scootery/ui/rounded_icon_button.dart';
import 'package:scootery/ui/text_with_icon_button.dart';

import 'model/scooters_model.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ScooterModel>(
              create: (context) => ScooterModel(scooterRepo: ScooterRepo())),
          ChangeNotifierProvider<MapsModel>(create: (context) => MapsModel())
        ],
        child: MaterialApp(
          title: 'Scootery',
          theme: ThemeData(primarySwatch: Colors.red),
          initialRoute: '/',
          routes: {'/': (context) => MyHomePage()},
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapsWidget2(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: RoundedIconButton(icon: Icons.assistant_photo),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: TextWithIconButton(
                          text: "Filter", icon: Icons.filter)),
                  Expanded(
                      child: TextWithIconButton(
                          text: "Scan", icon: Icons.qr_code_scanner)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
