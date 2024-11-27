import 'package:app_contable/pages/pages.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String loginPage = '/login';
  static const String homePage = '/home';
  static const String registerIncomingExpensePage =
      '/register_incoming_expense';
  static const String registerPage = '/register';

  Map<String, WidgetBuilder> get appRoutes {
    return {
      loginPage: (context) => const LoginPage(),
      homePage: (context) => const HomePage(),
      registerIncomingExpensePage: (context) =>
          const RegisterIncomingExpensePage(),
      registerPage: (context) => const RegisterPage(),
    };
  }
}
