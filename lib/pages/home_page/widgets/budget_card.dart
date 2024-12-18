import 'package:app_contable/pages/register_incoming_expense_page/bussines_logic/budget_logic.dart';
import 'package:flutter/material.dart';
import '../../../models/budget.dart';
import '../../../repository/transaction_repository.dart';
import '../../../variables/global_variables.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    super.key,
    required this.size,
    required this.budget,
  });

  final Size size;
  final Budget budget;
  final TextStyle dateTitleStyle = const TextStyle(
    fontSize: 12,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  );
  final TextStyle amountTitleStyle = const TextStyle(
    fontSize: 14,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  );

  final TextStyle allExpensesStyle = const TextStyle(
    fontSize: 14,
    color: Colors.deepPurple,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.purple,
      color: Colors.deepPurple[100],
      child: SizedBox(
        height: size.height * .4,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    GlobalVariables.dateToString(budget.initialDate),
                    style: dateTitleStyle,
                  ),
                  Text(
                    GlobalVariables.dateToString(budget.finalDate),
                    style: dateTitleStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                budget.description,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${budget.amountBudget}',
                style: amountTitleStyle,
              ),
              Expanded(
                child: FutureBuilder(
                  future: TransactionRepository().getTransactionsByDates(
                      budget.initialDate, budget.finalDate),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final transactions = snapshot.data;
                      if (transactions!.isNotEmpty) {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: transactions.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: size.height * .008,
                            );
                          },
                          itemBuilder: (context, index) {
                            final transaction = snapshot.data![index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  GlobalVariables.dateToString(
                                      transaction.date),
                                  style: dateTitleStyle.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  '${transaction.amount}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No hay transacciones para este periodo'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * .07,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FutureBuilder(
                      future: TransactionRepository().getTransactionsByDates(
                        budget.initialDate,
                        budget.finalDate,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final transactions = snapshot.data;
                          if (transactions!.isNotEmpty) {
                            double gastado =
                                BudgetLogic.allTransactionsAmount(transactions);
                            return Text(
                              'Gastado: $gastado',
                              style: allExpensesStyle.copyWith(
                                color: gastado * -1 > budget.amountBudget
                                    ? Colors.red
                                    : Colors.deepPurple,
                              ),
                            );
                          } else {
                            return Text(
                              'Gastado: 0.0',
                              style: allExpensesStyle,
                            );
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    FutureBuilder(
                      future: TransactionRepository().getTransactionsByDates(
                        budget.initialDate,
                        budget.finalDate,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final transactions = snapshot.data;
                          if (transactions!.isNotEmpty) {
                            double gastado =
                                BudgetLogic.allTransactionsAmount(transactions);
                            double saldo =
                                BudgetLogic.saldo(budget.amountBudget, gastado);
                            return Text(
                              'Saldo: $saldo',
                              style: allExpensesStyle.copyWith(
                                color: saldo < 0.0
                                    ? Colors.red
                                    : Colors.deepPurple,
                              ),
                            );
                          } else {
                            return Text(
                              'Saldo: 0.0',
                              style: allExpensesStyle,
                            );
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
