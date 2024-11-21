import 'package:app_contable/pages/login_page/bussines_logic/login_logic.dart';
import 'package:app_contable/pages/register_page/register_page.dart';
import 'package:app_contable/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .15,
          vertical: size.height * .1,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/stack_money.png',
                  width: size.width * .5,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'Ingrese su email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                          Text('Correro Electronico')
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'Ingrese su contraseña';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          Text('Contraseña')
                        ],
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Inciar Sesión'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text('Registrarse'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Olvidé mi contraseña'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      if (await LoginLogic().verifyUser(email, password)) {
        showCustomSnackBar('Logueado');
        nextPage();
      } else {
        showCustomSnackBar('No existe el usuario');
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
  
  void nextPage() {
    Navigator.pushNamed(context, Routes.homePage);
  }
}
