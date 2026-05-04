import 'package:transport_sy/features/cards/domain/entity/card.dart';

import '../../../core/domain/entity/base_entity.dart';
import '../enum/user_type.dart';

class User extends BaseEntity {
  String email;
  String password;
  String name;
  int balance;
  final UserType type;
  final List<Card>? card;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.balance,
    required this.type,
    required this.card,
    required super.deletable,
    required super.id,
  });
}

List<User> userList = [
  User(
    email: "1",
    password: "12345678",
    name: "Salem",
    balance: 10000,
    deletable: false,
    id: 0,
    card: [],
    type: UserType.rider,
  ),
  User(
    email: "2",
    password: "12345678",
    name: "Waseem",
    balance: 10000,
    deletable: false,
    id: 1,
    card: [],
    type: UserType.rider,
  ),
];
