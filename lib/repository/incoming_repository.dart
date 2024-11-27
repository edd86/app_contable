import 'package:app_contable/models/income.dart';
import '../data/database_helper.dart';

class IncomingRepository {
  Future<Income?> addIncome(Income income) async {
    try {
      final db = await DatabaseHelper().database;
      int incomeId = await db.insert('Incomes', income.toJson());
      return income.copyWith(id: incomeId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
