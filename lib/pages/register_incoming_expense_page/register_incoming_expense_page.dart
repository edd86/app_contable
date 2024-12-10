import 'package:app_contable/pages/register_incoming_expense_page/widgets/budget_widget.dart';
import 'package:app_contable/pages/register_incoming_expense_page/widgets/expenses_widget.dart';
import 'package:app_contable/pages/register_incoming_expense_page/widgets/incoming_widget.dart';
import 'package:flutter/material.dart';

class RegisterIncomingExpensePage extends StatelessWidget {
  const RegisterIncomingExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro Contable'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ingreso'),
              Tab(text: 'Gasto'),
              Tab(text: 'Presupuesto'),
              Tab(text: 'Prestamos')
            ],
            labelStyle: TextStyle(fontSize: 12),
          ),
        ),
        body: const TabBarView(children: [
          IncomingWidget(),
          ExpensesWidget(),
          BudgetWidget(),
          Center(child: Text('Prestamos')),
        ]),
      ),
    );
  }
}
