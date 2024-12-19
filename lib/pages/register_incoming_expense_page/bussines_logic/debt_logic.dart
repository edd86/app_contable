import 'package:app_contable/models/debt.dart';

class DebtLogic {
  static Debt createDebt(
      {required String creditor,
      required String description,
      required double amount,
      required DateTime dueDate,
      int? userId}) {
    return Debt(
        amount: amount,
        creditor: creditor,
        dueDate: dueDate,
        description: description,
        userId: userId);
  }

  static bool debtValidation(Debt? debt) {
    bool isValid = false;
    if (debt != null) {
      if (debt.id != null) {
        isValid = true;
      }
    }
    return isValid;
  }
}
