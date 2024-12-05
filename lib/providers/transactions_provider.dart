import 'package:app_contable/models/transaction.dart';
import 'package:app_contable/repository/transaction_repository.dart';
import 'package:flutter/material.dart';

class TransactionsProvider extends ChangeNotifier {
  final repository = TransactionRepository();

  List<Transaction>? _transactions = [];
  double _saldo = 0.0;

  TransactionsProvider() {
    _loadTransactions();
  }

  void _loadTransactions() async {
    _transactions = await repository.getTransactions();
    if (_transactions != null && _transactions!.isNotEmpty) {
      _saldo = _transactions!.fold(
          0.0, (previousValue, element) => previousValue + element.amount);
    }
    notifyListeners();
  }

  List<Transaction>? get transactions => _transactions;
  double get saldo => _saldo;

  loadTransactions() async {
    _loadTransactions();
  }
}
