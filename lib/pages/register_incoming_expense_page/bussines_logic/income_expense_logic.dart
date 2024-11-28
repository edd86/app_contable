import 'package:app_contable/models/income.dart';
import 'package:app_contable/models/transaction.dart';


class IncomeExpenseLogic {
  Transaction createTransaction(
      DateTime date, String type, String description, int userId) {
    return Transaction(
      date: date.toIso8601String(), //2024-01-01T00:00:00.000Z
      type: type,
      description: description,
      userId: userId,
    );
  }

  bool validateTransaction(Transaction? transaction) {
    bool isValid = false;
    if (transaction != null) {
      if (transaction.id != null) {
        isValid = true;
      }
    }
    return isValid;
  }

  Income createIncome(double parse, int i) {
    return Income(
      transactionId: i,
      amount: parse,
    );
  }

  bool validateIncome(Income? newIncome) {
    bool isValid = false;
    if (newIncome != null) {
      if (newIncome.id != null) {
        isValid = true;
      }
    }
    return isValid;
  }
}
