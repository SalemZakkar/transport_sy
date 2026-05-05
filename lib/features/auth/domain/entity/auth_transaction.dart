
enum AuthTransactionType { deposit, withdraw }

class AuthTransaction {
  final int id;
  final AuthTransactionType type;
  final String? notes;
  final int amount;
  final DateTime createdAt;
  final int userId;

  AuthTransaction({
    required this.id,
    required this.type,
    this.notes,
    required this.amount,
    required this.createdAt,
    required this.userId,
  });
}

List<AuthTransaction> authTransactions = [
  AuthTransaction(
    id: 1,
    type: AuthTransactionType.deposit,
    amount: 50000,
    notes: "رصيد افتتاحي",
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    userId: 1,
  ),
  // AuthTransaction(
  //   id: 2,
  //   type: AuthTransactionType.withdraw,
  //   amount: 2500,
  //   notes: "رحلة من البرامكة إلى المزة",
  //   createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  //   userId: 1,
  // ),
];
