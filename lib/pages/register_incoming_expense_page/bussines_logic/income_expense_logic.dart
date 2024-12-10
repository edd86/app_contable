import 'package:app_contable/models/expense.dart';
import 'package:app_contable/models/income.dart';
import 'package:app_contable/models/transaction.dart';

class IncomeExpenseLogic {
  Transaction createTransaction(
      DateTime date, String type, String description, double amount, int userId) {
    return Transaction(
      date: date, //2024-01-01T00:00:00.000Z
      type: type,
      description: description,
      amount: amount,
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

  Income createIncome(double amount, int transactioId) {
    return Income(
      transactionId: transactioId,
      amount: amount,
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

  Expense createExpense(double amount, int transactioId) {
    return Expense(
      amount: amount,
      transactionId: transactioId,
    );
  }

  bool validationExpense(Expense? newExpense) {
    bool isValid = false;
    if (newExpense != null) {
      if (newExpense.id != null) {
        isValid = true;
      }
    }
    return isValid;
  }
}
