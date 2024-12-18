import 'package:app_contable/models/budget.dart';
import 'package:app_contable/models/transaction.dart';
import 'package:app_contable/repository/transaction_repository.dart';

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

  static Future<bool> validateAmount(double amount) async {
    bool valid = false;
    final saldo = await TransactionRepository().getSaldo();
    if (saldo != null) {
      if (amount <= saldo) {
        valid = true;
      }
    }
    return valid;
  }

  static double allTransactionsAmount(List<Transaction> transactions) {
    double amount = 0.0;
    for (var transaction in transactions) {
      amount += transaction.amount;
    }
    return amount;
  }

  static double saldo(double amountBudget, double gastado) {
    return amountBudget + gastado;
  }
}
