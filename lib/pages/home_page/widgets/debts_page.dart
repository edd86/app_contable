import 'package:app_contable/repository/debt_repository.dart';
import 'package:flutter/material.dart';

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
    return FutureBuilder(
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
          return ListView.builder(
            itemCount: debts!.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.deepPurple,
                  child: ListTile(
                    title: Text(
                      debts[index].creditor,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    subtitle: Text(
                      debts[index].description ?? '',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      '${debts[index].amount}\$',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.deepPurple[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Text(
                      GlobalVariables.dateToString(debts[index].dueDate),
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
                          'Pagar deuda ${debts[index].creditor}',
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
                            onPressed: () {
                              double amount;
                              if (_amountController.text.isEmpty) {
                                showCustomSnackBar('Monto no puede ser vacío');
                              } else {
                                amount = double.parse(_amountController.text);
                                if (amount > debts[index].amount) {
                                  showCustomSnackBar(
                                      'Monto a pagar no puede ser mayor al monto de la deuda');
                                } else {
                                  showCustomSnackBar('Deuda pagada');
                                }
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        });
  }

  void showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(message),
      ),
    );
  }
}
