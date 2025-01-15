import 'package:app_contable/models/debt.dart';
import '../data/database_helper.dart';

class DebtRepository {
  Future<Debt?> addDebt(Debt debt) async {
    try {
      final db = await DatabaseHelper().database;
      final debtId = await db.insert('Debts', debt.toJson());
      return debt.copyWith(id: debtId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Debt>> getDebts() async {
    final List<Debt> allDebts = [];
    try {
      final db = await DatabaseHelper().database;
      final debts = await db.query('Debts');
      for (var debt in debts) {
        allDebts.add(Debt.fromJson(debt));
      }
      return allDebts;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<bool> payDebt(Debt debt, double amount) async {
    try {
      final db = await DatabaseHelper().database;
      final result = await db.query('Debts', where: 'id = ?', whereArgs: [debt.id]);
      final oldDebt = Debt.fromJson(result.first);
      final newDebt = oldDebt.copyWith(amount: oldDebt.amount - amount);
      await db.update('Debts', newDebt.toJson(), where: 'id = ?', whereArgs: [debt.id]);
      return true;
    }
    catch (e) {
      print(e.toString());
      return false;
    }
  }
}
