import 'package:app_contable/repository/budget_repository.dart';
import 'package:flutter/material.dart';
import 'budget_card.dart';

class BudgetsPage extends StatelessWidget {
  const BudgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * .005,
            horizontal: size.width * .1,
          ),
          child: FutureBuilder(
              future: BudgetRepository().getBudgets(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final budgets = snapshot.data;
                  if (budgets!.isEmpty) {
                    return const Center(
                      child: Text('No hay presupuestos registrados'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: budgets.length,
                      itemBuilder: (context, index) {
                        final budget = budgets[index];
                        return BudgetCard(
                          size: size,
                          budget: budget,
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
