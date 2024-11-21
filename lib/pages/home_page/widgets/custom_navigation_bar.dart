import 'package:app_contable/pages/home_page/widgets/destinations_bar.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: DestinationsBar.destinations,
      backgroundColor: Colors.deepPurple,
      indicatorColor: const Color(0xFF00b79a),
      selectedIndex: currentIndex,
      onDestinationSelected: (value) {
        setState(() {
          currentIndex = value;
        });
      },
    );
  }
}
