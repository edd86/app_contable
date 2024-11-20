class Transaction {
  int? id;
  String date;
  String type;
  String? description;
  int? userId;

  Transaction({
    this.id,
    required this.date,
    required this.type,
    this.description,
    this.userId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      description: json['description'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'description': description,
      'user_id': userId,
    };
  }

  Transaction copyWith({
    int? id,
    String? date,
    String? type,
    String? description,
    int? userId,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }
}