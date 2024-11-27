import 'package:flutter/material.dart';

final TextEditingController _incomingController = TextEditingController();

class IncomingWidget extends StatelessWidget {
  const IncomingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Center(
          child: TextField(
            controller: _incomingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: const Text('Monto del Ingreso'),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_incomingController.text.isEmpty) {
                    _showSnackBar(context, 'Ingrese un monto');
                  } else {
                    //TODO: Enviar ingresos a la Base de Datos.
                  }
                },
              ),
            ),
          ),
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
