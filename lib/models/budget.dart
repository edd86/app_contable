class Budget {
  int? id;
  String date;
  double incomeBudget;
  double expenseBudget;
  int? userId;

  Budget({
    this.id,
    required this.date,
    required this.incomeBudget,
    required this.expenseBudget,
    this.userId,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      date: json['date'],
      incomeBudget: json['income_budget'],
      expenseBudget: json['expense_budget'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'income_budget': incomeBudget,
      'expense_budget': expenseBudget,
      'user_id': userId,
    };
  }

  Budget copyWith({
    int? id,
    String? date,
    double? incomeBudget,
    double? expenseBudget,
    int? userId,
  }) {
    return Budget(
      id: id ?? this.id,
      date: date ?? this.date,
      incomeBudget: incomeBudget ?? this.incomeBudget,
      expenseBudget: expenseBudget ?? this.expenseBudget,
      userId: userId ?? this.userId,
    );
  }
}