// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:app_contable/repository/incoming_repository.dart';
import 'package:app_contable/repository/transaction_repository.dart';
import 'package:app_contable/variables/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bussines_logic/income_expense_logic.dart';
import 'package:app_contable/providers/export_providers.dart';

final TextEditingController _incomingController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
const labeStyle = TextStyle(
  fontSize: 12,
  color: Colors.deepPurple,
  fontWeight: FontWeight.w600,
);

class IncomingWidget extends StatelessWidget {
  const IncomingWidget({super.key});

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
              controller: _incomingController,
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
              onPressed: () async {
                if (_incomingController.text.isEmpty &&
                    _descriptionController.text.isEmpty) {
                  _showSnackBar(context, 'Rellena todos los campos');
                } else {
                  final transaction = IncomeExpenseLogic().createTransaction(
                    DateTime.now(),
                    'income',
                    _descriptionController.text,
                    double.parse(_incomingController.text),
                    GlobalVariables.userLogged!.id!,
                  );
                  final newTransaction =
                      await TransactionRepository().addTransaction(transaction);
                  if (IncomeExpenseLogic()
                      .validateTransaction(newTransaction)) {
                    final income = IncomeExpenseLogic().createIncome(
                        double.parse(_incomingController.text),
                        newTransaction!.id!);
                    final newIncome =
                        await IncomingRepository().addIncome(income);
                    if (IncomeExpenseLogic().validateIncome(newIncome)) {
                      _showSnackBar(context, 'Transacción creada exitosamente');
                      _modifyListeners(context);
                      _cleanControllers();
                    } else {
                      _showSnackBar(context, 'Transacción no creada');
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

  void _cleanControllers() {
    _incomingController.clear();
    _descriptionController.clear();
  }

  void _modifyListeners(BuildContext context) {
    final notifier = Provider.of<TransactionsProvider>(context, listen: false);
    notifier.loadTransactions();
  }
}
