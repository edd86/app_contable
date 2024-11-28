// ignore_for_file: use_build_context_synchronously

import 'package:app_contable/repository/incoming_repository.dart';
import 'package:app_contable/repository/transaction_repository.dart';
import 'package:app_contable/variables/global_variables.dart';
import 'package:flutter/material.dart';

import '../bussines_logic/income_expense_logic.dart';

final TextEditingController _incomingController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();

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
              controller: _incomingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Monto del Ingreso'),
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('Descripción'),
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
                    IncomeExpenseLogic().validateIncome(newIncome)
                        ? _showSnackBar(
                            context, 'Transacción creada exitosamente')
                        : _showSnackBar(context, 'Transacción no creada');
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
}
