class Budget {
  int? id;
  DateTime initialDate;
  DateTime finalDate;
  double amountBudget;
  String description;
  int? userId;

  Budget({
    this.id,
    required this.initialDate,
    required this.finalDate,
    required this.amountBudget,
    required this.description,
    this.userId,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      initialDate: DateTime.parse(json['initial_date']),
      finalDate: DateTime.parse(json['final_date']),
      amountBudget: json['income_budget'],
      description: json['expense_budget'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initial_date': initialDate.toIso8601String(),
      'final_date': finalDate.toIso8601String(),
      'amount_budget': amountBudget,
      'description': description,
      'user_id': userId,
    };
  }

  Budget copyWith({
    int? id,
    DateTime? initialDate,
    DateTime? finalDate,
    double? amountBudget,
    String? description,
    int? userId,
  }) {
    return Budget(
      id: id ?? this.id,
      initialDate: initialDate ?? this.initialDate,
      finalDate: finalDate ?? this.finalDate,
      amountBudget: amountBudget ?? this.amountBudget,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }
}
