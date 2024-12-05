import 'package:app_contable/providers/export_providers.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TransactionsProvider>(create: (_) => TransactionsProvider()) 
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes().appRoutes,
      initialRoute: Routes.loginPage,
    );
  }
}
