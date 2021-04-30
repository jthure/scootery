import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scootery/model/scooters_model.dart';
import 'package:provider/provider.dart';

class SelectionWindow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var selectedScooter = context.select((ScooterModel m) => m.selectedScooter);
    if(selectedScooter == null) return SizedBox.shrink();
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${selectedScooter.provider}"),
          TextButton(onPressed: () => {}, child: const Text("Go to this scooter"))
        ],
      )
    );
  }

}