import 'package:app_contable/models/budget.dart';
import '../data/database_helper.dart';

class BudgetRepository {
  Future<Budget?> addBudget(Budget budget) async {
    final db = await DatabaseHelper().database;
    try {
      final budgetId = await db.insert('Budgets', budget.toJson());
      return budget.copyWith(id: budgetId);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Budget>?> getBudgets() async {
    List<Budget> budgets = [];
    try {
      final db = await DatabaseHelper().database;
      final budgetsInDatabase = await db.query('Budgets');
      for (var budget in budgetsInDatabase) {
        budgets.add(Budget.fromJson(budget));
      }
      return budgets;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  
}
