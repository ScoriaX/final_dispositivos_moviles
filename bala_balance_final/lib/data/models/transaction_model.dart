// Descripción: Modelo de Transaccion
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 5/12/2025

class TransactionModel {
  final int? id;
  final double amount;
  final String type;
  final int categoryId;
  final String? description;
  final String date;

  TransactionModel({
    this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'categoryId': categoryId,
      'description': description,
      'date': date,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'],
      type: map['type'],
      categoryId: map['categoryId'],
      description: map['description'],
      date: map['date'],
    );
  }
}
