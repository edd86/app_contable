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
}
