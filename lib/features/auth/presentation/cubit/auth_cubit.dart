import 'package:core_package/core_package.dart';
import 'package:transport_sy/features/auth/domain/entity/user.dart';
import 'package:transport_sy/features/auth/domain/enum/user_type.dart';

import 'auth_state.dart';

class AuthState {
  AuthStateType authState;

  AuthState({
    this.authState = AuthStateType.initial,
    this.userData,
    this.withPush = false,
  });

  User? userData;

  bool withPush;

  User get user {
    if (userData == null) {
      throw Exception("UNAUTH");
    }
    return userData!;
  }

  bool get authenticated => userData != null;
}

@lazySingleton
class AuthCubit extends HydratedCubit<AuthState> {
  // AuthRepository authRepository;

  AuthCubit() : super(AuthState()) {
    // authRepository.authStream.listen((e) {
    //   emitAuthState(e);
    // });
  }

  void init() {
    emit(state);
  }

  void complete(String name) {
    var old = userList.where((e) => state.user.id == e.id).first;
    old.name = name;
    emit(
      AuthState(
        withPush: true,
        userData: old,
        authState: AuthStateType.authenticated,
      ),
    );
  }

  User? login(String phone) {
    // print(phone);
    // print("********");
    User? user = userList.where((e) => e.phone == phone).firstOrNull;
    if (user == null) {
      user = User(
        // cards: [],
        name: null,
        type: UserType.rider,
        deletable: false,
        id: userList.length,
        phone: phone,
      );
      userList.add(user);
    }
    emit(
      AuthState(
        authState: AuthStateType.authenticated,
        withPush: true,
        userData: user,
      ),
    );
    return user;
  }

  void logout() {
    emit(AuthState(authState: AuthStateType.unAuth));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState(
      authState: AuthStateType.fromString(json['state']),
      userData: userList.where((e) => e.id == json['id']).first,
      withPush: true,
    );
    return state;
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {"state": state.authState.getString(), "id": state.userData?.id};
  }
}
