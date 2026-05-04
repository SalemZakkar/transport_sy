import 'package:transport_sy/features/auth/domain/entity/user.dart';

class UserStreamSignal {
  User? user;
  bool withPush;
  UserStreamSignal({this.user, required this.withPush});
}
