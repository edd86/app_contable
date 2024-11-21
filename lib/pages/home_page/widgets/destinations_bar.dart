import 'package:flutter/material.dart';

class DestinationsBar {
  static const List<Widget> destinations = [
    NavigationDestination(
      icon: Icon(
        Icons.transfer_within_a_station,
      ),
      label: 'Transferencias',
    ),
    NavigationDestination(
      icon: Icon(Icons.money),
      label: 'Presupuesto',
    ),
  ];
}
