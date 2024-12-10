import 'package:app_contable/variables/global_variables.dart';
import 'package:flutter/material.dart';

import '../bussines_logic/budget_logic.dart';

class BudgetWidget extends StatefulWidget {
  const BudgetWidget({super.key});

  @override
  State<BudgetWidget> createState() => _BudgetWidgetState();
}

class _BudgetWidgetState extends State<BudgetWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime initDate = DateTime.now();  //2024-12-10T08:19:30.526Z
  DateTime finalDate = DateTime.now(); //2024-12-10T08:19:30.656Z

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            size.width * .15, size.height * .05, size.width * .15, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Monto del Presupuesto'),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.isEmpty) {
                    return 'Debe llenar un monto de presupuesto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Debe ingresar un monto válido';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * .05,
              ),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Descripción'),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.isEmpty) {
                    return 'Debe agregar una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(
                        'Inicial: ${GlobalVariables.dateToString(initDate)}'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Text(
                        'Final: ${GlobalVariables.dateToString(finalDate)}'),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .05,
              ),
              ElevatedButton.icon(
                label: const Text('Registrar'),
                icon: const Icon(Icons.save),
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      finalDate.day != initDate.day) {
                    final amount = double.parse(_amountController.text);
                    final description = _descriptionController.text;
                    if (amount > 0.0) {
                      //TODO: Capturar Fechas de inicio y final
                      final budget = BudgetLogic().createBudget(
                        amount,
                        description,
                        initDate,
                        finalDate,
                        GlobalVariables.userLogged!.id!,
                      );
                    } else {
                      showCustomSnackBar('El monto debe ser mayor a 0');
                    }
                  } else {
                    showCustomSnackBar(
                        'Por favor llene todos los campos o verifique la fecha de inicio y final');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
