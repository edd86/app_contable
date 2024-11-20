import 'package:app_contable/models/user.dart';
import 'package:flutter/material.dart';

import '../../repository/user_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Registro de Usuario'),
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .15,
              vertical: size.height * .01,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * .01),
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      label: Text('Nombre Completo'),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'Ingrese su nombre completo';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, size.height * .01, 0, size.height * .01),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.deepPurple,
                      ),
                      label: Text('Correo Electronico'),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'Ingrese su correo electronico';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, size.height * .01, 0, size.height * .1),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.password,
                        color: Colors.deepPurple,
                      ),
                      label: const Text('Contraseña'),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _obscureText = !_obscureText;
                        }),
                        icon: _obscureText
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'Ingrese su Contraseña';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.save),
                  label: const Text('Guaradar Usuario'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final user = User(name: name, email: email, password: password);
      final newUser = await UserRepository().addUser(user);
      if (newUser != null) {
        showCustomSnackBar('Usuario creado exitosamente');
      } else {
        showCustomSnackBar('Usuario no creado');
      }
    } else {
      showCustomSnackBar('Por favor llene todos los campos');
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
}
