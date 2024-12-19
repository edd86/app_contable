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
}
