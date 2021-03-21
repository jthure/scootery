import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'scooter.dart';

class ScooterModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Scooter> _items = [];
  var count = 1;

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Scooter> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Scooter item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void increment(){
    count = count+1;
    notifyListeners();
  }
}