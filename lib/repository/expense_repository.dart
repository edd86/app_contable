import 'package:app_contable/models/expense.dart';
import '../data/database_helper.dart';

class ExpenseRepository {
  Future<Expense?> addExpense(Expense expense) async {
    try {
      final db = await DatabaseHelper().database;
      final expenseJson = expense.toJson();
      int expenseId = await db.insert('Expenses', expenseJson);
      return expense.copyWith(id: expenseId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /* Future<double> getAmountByTransactionId(int transactionId) async {
    try {
      final db = await DatabaseHelper().database;
      final result = await db.query('Expenses', where: 'transaction_id = ?', whereArgs: [transactionId]);
      final expense = Expense.fromJson(result.first);
      return expense.amount;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  } */
}
