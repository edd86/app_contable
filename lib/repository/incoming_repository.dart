import 'package:app_contable/models/income.dart';
import '../data/database_helper.dart';

class IncomingRepository {

  Future<Income?> addIncome(Income income) async {
    try {
      final db = await DatabaseHelper().database;
      final incomeJson = income.toJson();
      int incomeId = await db.insert('Incomes', incomeJson);
      return income.copyWith(id: incomeId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /* Future<double> getAmountByTransactionId(int transactionId) async {
    try {
      final db = await DatabaseHelper().database;
      final result = await db.query('Incomes', where: 'transaction_id = ?', whereArgs: [transactionId]);
      final income = Income.fromJson(result.first);
      return income.amount;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  } */
}
