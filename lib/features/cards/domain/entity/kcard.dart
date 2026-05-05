import 'package:transport_sy/features/core/domain/entity/base_entity.dart';

class KCard extends BaseEntity {
  final String number;
  final int balance;
  final int userId;

  KCard({
    required super.id,
    required this.number,
    required this.balance,
    required this.userId,
    required super.deletable,
  });

  @override
  String toString() => 'Card(****${number.substring(number.length - 4)})';
}

List<KCard> cards = [
  KCard(id: 0, number: "1113345", balance: 20000, userId: 1, deletable: false),
  KCard(id: 1, number: "5436456", balance: 43532, userId: 1, deletable: false),
];
