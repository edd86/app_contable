class Income {
  int? id;
  int? transactionId;
  double amount;

  Income({
    this.id,
    this.transactionId,
    required this.amount,
  });

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
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

  Income copyWith({
    int? id,
    int? transactionId,
    double? amount,
  }) {
    return Income(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
    );
  }
}