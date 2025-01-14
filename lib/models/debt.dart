class Debt {
  int? id;
  String creditor;
  double amount;
  DateTime dueDate;
  String? description;
  int? userId;

  //TODO: Agregar una flag para saber si la deuda fue pagada

  Debt({
    this.id,
    required this.creditor,
    required this.amount,
    required this.dueDate,
    this.description,
    this.userId,
  });

  factory Debt.fromJson(Map<String, dynamic> json) {
    return Debt(
      id: json['id'],
      creditor: json['creditor'],
      amount: json['amount'],
      dueDate: DateTime.parse(json['due_date']),
      description: json['description'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creditor': creditor,
      'amount': amount,
      'due_date': dueDate.toIso8601String(),
      'description': description,
      'user_id': userId,
    };
  }

  Debt copyWith({
    int? id,
    String? creditor,
    double? amount,
    String? dueDate,
    String? description,
    int? userId,
  }) {
    return Debt(
      id: id ?? this.id,
      creditor: creditor ?? this.creditor,
      amount: amount ?? this.amount,
      dueDate: dueDate != null ? DateTime.parse(dueDate) : this.dueDate,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }
}
