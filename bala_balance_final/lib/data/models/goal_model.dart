class GoalModel {
  final int? id;
  final String title;
  final double totalAmount;
  final double savedAmount;

  GoalModel({
    this.id,
    required this.title,
    required this.totalAmount,
    required this.savedAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'totalAmount': totalAmount,
      'savedAmount': savedAmount,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      savedAmount: (map['savedAmount'] as num).toDouble(),
    );
  }
}
