import 'package:app_contable/models/income.dart';
import '../data/database_helper.dart';

class IncomingRepository {

  //TODO: Solucionar bug de addIncome no se registra en la Base de Datos.
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
}
