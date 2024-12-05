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
      return transactionsRegistered;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}