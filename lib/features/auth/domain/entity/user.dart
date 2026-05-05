
import '../../../core/domain/entity/base_entity.dart';
import '../enum/user_type.dart';

class User extends BaseEntity {
  String? name;
  final UserType type;
  final String phone;
  // List<KCard> cards;

  bool get active => name?.isNotEmpty == true;

  User({
    required this.name,
    required this.type,
    required super.deletable,
    required super.id,
    required this.phone,
    // required this.cards,
  });
}

List<User> userList = [
  User(
    phone: "+963949123587",
    deletable: false,
    id: 0,
    type: UserType.rider,
    name: "Salem",
    // cards: [cards[0], cards[1], cards[2]],
  ),
  User(
    phone: "+963949123588",
    name: "Waseem",
    deletable: false,
    id: 1,
    type: UserType.rider,
    // cards: [cards[3], cards[4], cards[5]],
  ),
];
