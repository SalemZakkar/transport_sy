import 'package:transport_sy/features/core/domain/entity/base_entity.dart';

class User extends BaseEntity {
  String email;
  String password;
  String name;
  int balance;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.balance,
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
  ),
  User(
    email: "2",
    password: "12345678",
    name: "Waseem",
    balance: 10000,
    deletable: false,
    id: 1,
  ),
];
