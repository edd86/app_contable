// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:app_contable/providers/export_providers.dart';
import 'package:app_contable/repository/expense_repository.dart';
import 'package:app_contable/repository/transaction_repository.dart';
import 'package:app_contable/variables/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bussines_logic/income_expense_logic.dart';

final TextEditingController _expenseController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
const labeStyle = TextStyle(
  fontSize: 12,
  color: Colors.deepPurple,
  fontWeight: FontWeight.w600,
);

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, vertical: size.height * 0.025),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              style: labeStyle.copyWith(color: Colors.black),
              decoration: const InputDecoration(
                label: Text(
                  'Descripción',
                  style: labeStyle,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            TextField(
              controller: _expenseController,
              keyboardType: TextInputType.number,
              style: labeStyle.copyWith(color: Colors.black),
              decoration: const InputDecoration(
                label: Text(
                  'Monto',
                  style: labeStyle,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            ElevatedButton.icon(
              label: const Text('Registrar'),
              icon: const Icon(Icons.save),
              //TODO: Validar gastos por presupuesto.
              onPressed: () async {
                if (_expenseController.text.isEmpty &&
                    _descriptionController.text.isEmpty) {
                  _showSnackBar(context, 'Rellena todos los campos');
                } else {
                  final transaction = IncomeExpenseLogic().createTransaction(
                    DateTime.now(),
                    'expense',
                    _descriptionController.text,
                    double.parse(_expenseController.text) * -1,
                    GlobalVariables.userLogged!.id!,
                  );
                  final newTransaction =
                      await TransactionRepository().addTransaction(transaction);
                  if (IncomeExpenseLogic()
                      .validateTransaction(newTransaction)) {
                    if (double.parse(_expenseController.text) > 0.0) {
                      final expense = IncomeExpenseLogic().createExpense(
                          double.parse(_expenseController.text),
                          newTransaction!.id!);
                      final newExpense =
                          await ExpenseRepository().addExpense(expense);
                      if (IncomeExpenseLogic().validationExpense(newExpense)) {
                        _showSnackBar(context, 'Transacción creada');
                        _modifyListeners(context);
                        _cleanControllers();
                      } else {
                        _showSnackBar(context, 'Transacción no creada');
                      }
                    } else {
                      _showSnackBar(context, "El monto debe ser mayor a 0");
                    }
                  } else {
                    _showSnackBar(context, 'Transacción no creada');
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(message),
      ),
    );
  }

  void _modifyListeners(BuildContext context) {
    final notifier = Provider.of<TransactionsProvider>(context, listen: false);
    notifier.loadTransactions();
  }

  void _cleanControllers() {
    _expenseController.clear();
    _descriptionController.clear();
  }
}
