import 'package:app_contable/models/expense.dart';
import 'package:app_contable/pages/register_incoming_expense_page/bussines_logic/income_expense_logic.dart';
import 'package:app_contable/repository/debt_repository.dart';
import 'package:app_contable/repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/transaction.dart';
import '../../../providers/transactions_provider.dart';
import '../../../repository/transaction_repository.dart';
import '../../../variables/global_variables.dart';

class DebtsPage extends StatefulWidget {
  const DebtsPage({super.key});

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

TextEditingController _amountController = TextEditingController();

class _DebtsPageState extends State<DebtsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder(
          future: DebtRepository().getDebts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error al cargar los datos',
                  style: TextStyle(fontSize: 10),
                ),
              );
            }
            final debts = snapshot.data;
            final pendingDebts =
                debts!.where((debt) => debt.amount > 0).toList();
            return ListView.builder(
              itemCount: pendingDebts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  focusColor: Colors.deepPurple[200],
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.deepPurple,
                    child: ListTile(
                      title: Text(
                        pendingDebts[index].creditor,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      subtitle: Text(
                        pendingDebts[index].description ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Text(
                        '${pendingDebts[index].amount}\$',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.deepPurple[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Text(
                        GlobalVariables.dateToString(
                            pendingDebts[index].dueDate),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Pagar deuda ${pendingDebts[index].creditor}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          content: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text(
                                'Monto a pagar',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.deepPurple[800],
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple[800],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.deepPurple[600],
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text(
                                'Pagar',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.deepPurple[900],
                                ),
                              ),
                              onPressed: () async {
                                double amount;
                                if (_amountController.text.isEmpty) {
                                  showCustomSnackBar(
                                      'Monto no puede ser vacío');
                                } else {
                                  amount = double.parse(_amountController.text);
                                  if (amount > pendingDebts[index].amount) {
                                    showCustomSnackBar(
                                        'Monto a pagar no puede ser mayor al monto de la deuda');
                                  } else {
                                    final response = await DebtRepository()
                                        .payDebt(pendingDebts[index], amount);
                                    if (response) {
                                      Transaction transaction =
                                          IncomeExpenseLogic()
                                              .createTransaction(
                                        DateTime.now(),
                                        'expense',
                                        'Pago a ${pendingDebts[index].creditor} por ${pendingDebts[index].description}',
                                        amount,
                                        GlobalVariables.userLogged!.id!,
                                      );
                                      showCustomSnackBar('Deuda pagada');
                                      final transactionResponse =
                                          await TransactionRepository()
                                              .addTransaction(transaction);
                                      if (transactionResponse != null) {
                                        showCustomSnackBar(
                                            'Transacción registrada');
                                        Expense expense =
                                            IncomeExpenseLogic().createExpense(
                                          amount,
                                          transactionResponse.id!,
                                        );
                                        await ExpenseRepository()
                                            .addExpense(expense);
                                        _modifyListeners();
                                      } else {
                                        showCustomSnackBar(
                                            'No se pudo registrar la transacción');
                                      }
                                      setState(() {
                                        _amountController.clear();
                                      });
                                    } else {
                                      showCustomSnackBar(
                                          'No se pudo guarda el pago de la deuda');
                                    }
                                  }
                                }
                                navigationBack();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onLongPress: () async {
                    final debt = pendingDebts[index];
                    final response =
                        await DebtRepository().payDebt(debt, debt.amount);
                    if (response) {
                      Transaction transaction =
                          IncomeExpenseLogic().createTransaction(
                        DateTime.now(),
                        'expense',
                        'Pago a ${debt.creditor} por ${debt.description}',
                        debt.amount,
                        GlobalVariables.userLogged!.id!,
                      );
                      final transactionResponse = await TransactionRepository()
                          .addTransaction(transaction);
                      if (transactionResponse != null) {
                        showCustomSnackBar('Transacción registrada');
                        Expense expense = IncomeExpenseLogic().createExpense(
                          debt.amount,
                          transactionResponse.id!,
                        );
                        await ExpenseRepository().addExpense(expense);
                        _modifyListeners();
                      }
                      setState(() {});
                    } else {
                      showCustomSnackBar(
                          'No se pudo guardar el pago de la deuda');
                    }
                  },
                );
              },
            );
          }),
    );
  }

  void showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(message),
      ),
    );
  }

  void _modifyListeners() {
    final notifier = Provider.of<TransactionsProvider>(context, listen: false);
    notifier.loadTransactions();
  }

  void navigationBack() {
    Navigator.pop(context);
  }
}
