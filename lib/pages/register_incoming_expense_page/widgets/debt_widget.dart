import 'package:app_contable/repository/debt_repository.dart';
import 'package:app_contable/variables/global_variables.dart';
import 'package:flutter/material.dart';

import '../bussines_logic/debt_logic.dart';

class DebtWidget extends StatefulWidget {
  const DebtWidget({super.key});

  @override
  State<DebtWidget> createState() => _DebtWidgetState();
}

class _DebtWidgetState extends State<DebtWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _creditorController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime dueDate = DateTime.now();
  final labeStyle = const TextStyle(
    fontSize: 12,
    color: Colors.deepPurple,
    fontWeight: FontWeight.w600,
  );
  @override
  void dispose() {
    _creditorController.dispose();
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
          size.width * .15,
          size.height * .05,
          size.width * .15,
          0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _creditorController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: labeStyle.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  label: Text(
                    'Titular',
                    style: labeStyle,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.isEmpty) {
                    return 'Debe agregar un titular';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * .025,
              ),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                style: labeStyle.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  label: Text(
                    'Descripción',
                    style: labeStyle,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .025,
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: labeStyle.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  label: Text(
                    'Monto',
                    style: labeStyle,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.isEmpty) {
                    return 'Debe llenar un monto de prestamo';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Debe ingresar un monto válido';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * .045,
              ),
              TextButton(
                child: Text(GlobalVariables.dateToString(dueDate)),
                onPressed: () {
                  _selectedDate();
                },
              ),
              SizedBox(
                height: size.height * .045,
              ),
              ElevatedButton.icon(
                label: const Text('Registrar'),
                icon: const Icon(Icons.save),
                onPressed: _submitForm,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final creditor = _creditorController.text;
      final description = _descriptionController.text;
      final amount = double.parse(_amountController.text);
      final debt = DebtLogic.createDebt(
        creditor: creditor,
        description: description,
        amount: amount,
        dueDate: dueDate,
        userId: GlobalVariables.userLogged!.id,
      );
      final newDebt = await DebtRepository().addDebt(debt);
      if (DebtLogic.debtValidation(newDebt)) {
        showCustomSnackBar('Préstamo registrado exitosamente');
        _cleanControllers();
      } else {
        showCustomSnackBar('Error al registrar el préstamo');
      }
    }
  }

  void showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  void _selectedDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year).add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        dueDate = pickedDate;
      });
    }
  }

  void _cleanControllers() {
    _creditorController.clear();
    _amountController.clear();
    _descriptionController.clear();
    setState(() {
      dueDate = DateTime.now();
    });
  }
}
