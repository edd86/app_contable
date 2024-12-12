import 'package:app_contable/models/budget.dart';

class BudgetLogic {
  Budget createBudget(double amount, String description, DateTime initDate,
      DateTime finalDate, int userId) {
    return Budget(
      initialDate: initDate,
      finalDate: finalDate,
      amountBudget: amount,
      description: description,
      userId: userId,
    );
  }

  static bool validateBudget(Budget? budget) {
    bool valid = false;
    if (budget != null) {
      if (budget.id != null) {
        valid = true;
      }
    }
    return valid;
  }
}
