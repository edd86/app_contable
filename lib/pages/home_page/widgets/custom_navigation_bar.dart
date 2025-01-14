import 'package:app_contable/pages/home_page/widgets/budgets_page.dart';
import 'package:app_contable/pages/home_page/widgets/destinations_bar.dart';
import 'package:app_contable/pages/home_page/widgets/transaction_page.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import 'debts_page.dart';

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
          const TransactionPage(),
          const BudgetsPage(),
          const DebtsPage(),
        ][currentIndex],
        bottomNavigationBar: NavigationBar(
          destinations: DestinationsBar.destinations,
          backgroundColor: Colors.deepPurple[200],
          indicatorColor: const Color(0xFF00b79a),
          selectedIndex: currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.add,
            color: Color(0xFF00b79a),
          ),
          onPressed: () =>
              Navigator.pushNamed(context, Routes.registerIncomingExpensePage),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
