import 'package:app_contable/models/transaction.dart';
import '../data/database_helper.dart';

class TransactionRepository {
  Future<Transaction?> addTransaction(Transaction transaction) async {
    try {
      final db = await DatabaseHelper().database;
      int transactionId = await db.insert('Transactions', transaction.toJson());
      return transaction.copyWith(id: transactionId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Transaction>?> getTransactions() async {
    List<Transaction> transactionsRegistered = [];
    try {
      final db = await DatabaseHelper().database;
      final transactions = await db.query('Transactions');
      for (var element in transactions) {
        transactionsRegistered.add(Transaction.fromJson(element));
      }
      transactionsRegistered.sort((a, b) => b.date.compareTo(a.date));
      return transactionsRegistered;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Transaction>?> getTransactionsByDates(
      DateTime initialDate, DateTime finalDate) async {
    List<Transaction>? transactionsRegistered = await getTransactions();
    if (transactionsRegistered != null) {
      transactionsRegistered.removeWhere((transaction) =>
          transaction.date.isBefore(initialDate) &&
          transaction.date.isAfter(finalDate));
      return transactionsRegistered
          .where((transaction) => transaction.type == 'expense')
          .toList();
    } else {
      return null;
    }
  }

  /* double getSaldo() async {
    final transactionsRegistered = await getTransactions();
    if (transactionsRegistered != null) {
      return transactionsRegistered.fold(
          0.0, (previousValue, element) => previousValue + element.amount);
    }

  } */
  //saldo = _transactions!.fold(0.0, (previousValue, element) => previousValue + element.amount);
}
