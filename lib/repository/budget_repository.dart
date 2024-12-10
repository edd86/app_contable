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
}
