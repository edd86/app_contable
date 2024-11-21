import 'package:app_contable/pages/pages.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String loginPage = '/login';
  static const String homePage = '/home';

  Map<String, WidgetBuilder> get appRoutes {
    return {
      loginPage: (context) => const LoginPage(),
      homePage: (context) => const HomePage(),
    };
  }
}
