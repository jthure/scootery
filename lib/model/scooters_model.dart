import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scootery/data/scooter_repo.dart';
import 'package:scootery/extensions/extensions.dart';
import 'package:scootery/gen/assets.gen.dart';

import 'scooter.dart';

class ScooterModel extends ChangeNotifier {
  final ScooterRepo scooterRepo;
  Image icon = Image.asset(Assets.scooter64.path);

  ScooterModel({required this.scooterRepo});

  List<Scooter> _items = [];

  UnmodifiableListView<Scooter> get items => UnmodifiableListView(_items);

  Scooter? _selectedScooter;

  Scooter? get selectedScooter => _selectedScooter;

  void fetchScooters(double latitude, double longitude) async {
    var result = await scooterRepo.fetchScooters(latitude, longitude);
    var iconNames = result.scooters.map((e) => e.assetKey()).unique().toList();
    var icons = iconNames.map((e) =>
        Image.asset('assets/$e.png')).toList();
    //var icons = await Future.wait(iconsFutures);
    var defaultIcon = this.icon;
    var iconsByName = Map<String, Image>();
    for (var i = 0; i < iconNames.length; ++i) {
      iconsByName[iconNames[i]] = icons[i];
    }
    _items = result.scooters.map((e) =>
        Scooter(
          provider: e.provider,
          id: e.id,
          lat: e.lat,
          lng: e.lng,
          icon: iconsByName.containsKey(e.assetKey()) ? iconsByName[e.assetKey()]! : defaultIcon,
        )).toList();
    notifyListeners();
  }

  void selectScooter(String id) {
    _selectedScooter = items.firstWhere((s) => s.id == id);
    notifyListeners();
  }

  void resetSelectedScooter() {
    _selectedScooter = null;
    notifyListeners();
  }
}
