import 'package:transport_sy/features/auth/domain/entity/user.dart';

class Card {
  final String id;
  final String number;
  final User owner; // Card owner (must be a rider)

  Card({required this.id, required this.number, required this.owner});

  @override
  String toString() => 'Card(****${number.substring(number.length - 4)})';
}
