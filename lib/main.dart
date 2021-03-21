import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scootery/model/maps_model.dart';
import 'package:scootery/ui/map_widget.dart';

import 'model/scooters_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ScooterModel(),
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
    var scooters = context.watch<ScooterModel>();
    return Scaffold(
      appBar: AppBar(title: Text('Scootery')),
      body: Center(
        child: MultiProvider(
          providers: [ChangeNotifierProvider<MapsModel>(create: (context) => MapsModel())],
          child: MapsWidget(),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scooters.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
