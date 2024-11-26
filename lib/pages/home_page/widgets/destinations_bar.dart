import 'package:flutter/material.dart';

class DestinationsBar {
  static const List<Widget> destinations = [
    NavigationDestination(
      icon: Icon(
        Icons.transfer_within_a_station,
      ),
      label: 'Transacciones',
    ),
    NavigationDestination(
      icon: Icon(Icons.money),
      label: 'Presupuesto',
    ),
    NavigationDestination(
      icon: Icon(Icons.cloud),
      label: 'Deudas',
    )
  ];
}
