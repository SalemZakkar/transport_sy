import '../../../core/domain/entity/base_entity.dart';
import '../enum/user_type.dart';

class User extends BaseEntity {
  String? name;
  final DateTime birth;
  final UserType type;
  final String city;
  final String phone;
  final String gender;
  final String address;
  int balance;

  // List<KCard> cards;

  bool get active => name?.isNotEmpty == true;

  User({
    required this.name,
    required this.type,
    required super.deletable,
    required super.id,
    required this.phone,
    this.balance = 0,
    required this.birth,
    required this.address,
    required this.city,
    required this.gender,
  });
}

List<User> userList = [
  User(
    phone: "+963949123587",
    deletable: false,
    id: 1,
    type: UserType.rider,
    name: "Salem",
    birth: DateTime(2001, 1, 1),
    city: "Homs",
    balance: 10000,
    gender: "ذكر",
    address: "الإنشاءات",
  ),
];
