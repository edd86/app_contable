import 'package:app_contable/pages/home_page/widgets/destinations_bar.dart';
import 'package:app_contable/pages/home_page/widgets/transfers_page.dart';
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
    return SafeArea(
      child: Scaffold(
        body: <Widget>[
          const TransfersPage(),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.redAccent,
          )
        ][currentIndex],
        bottomNavigationBar: NavigationBar(
          destinations: DestinationsBar.destinations,
          backgroundColor: Colors.deepPurple,
          indicatorColor: const Color(0xFF00b79a),
          selectedIndex: currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }
}
