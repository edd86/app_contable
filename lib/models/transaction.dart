class Transaction {
  int? id;
  String date;
  String type;
  String? description;
  double amount;
  int? userId;

  Transaction({
    this.id,
    required this.date,
    required this.type,
    this.description,
    required this.amount,
    this.userId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      description: json['description'],
      amount: json['amount'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'description': description,
      'amount': amount,
      'user_id': userId,
    };
  }

  Transaction copyWith({
    int? id,
    String? date,
    String? type,
    String? description,
    double? amount,
    int? userId,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
    );
  }
}