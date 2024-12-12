import 'package:flutter/material.dart';
import '../../../models/budget.dart';
import '../../../variables/global_variables.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    super.key,
    required this.size,
    required this.budget,
  });

  final Size size;
  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: size.height * .4,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(GlobalVariables.dateToString(budget.initialDate)),
                Text(GlobalVariables.dateToString(budget.finalDate)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(budget.description),
            Text('${budget.amountBudget}'),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 250,
              height: 150,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
