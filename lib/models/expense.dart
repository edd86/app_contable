class Expense {
  int? id;
  int? transactionId;
  double amount;

  Expense({
    this.id,
    this.transactionId,
    required this.amount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      transactionId: json['transaction_id'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'amount': amount,
    };
  }

  Expense copyWith({
    int? id,
    int? transactionId,
    double? amount,
  }) {
    return Expense(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
    );
  }
}