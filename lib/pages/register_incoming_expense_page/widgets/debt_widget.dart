import 'package:app_contable/variables/global_variables.dart';
import 'package:flutter/material.dart';

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
                decoration: InputDecoration(
                  label: Text(
                    'Monto del Prestamo',
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
                onPressed: () {},
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
      //TODO: Agregar el prestamo a la base de datos
    }
  }
}
