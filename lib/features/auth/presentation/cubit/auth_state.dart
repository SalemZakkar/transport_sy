enum AuthStateType {
  authenticated,
  blocked,
  unActivated,
  initial,
  unAuth;

  static AuthStateType fromString(String? state) {
    switch (state) {
      case 'authenticated':
        return AuthStateType.authenticated;
      case 'blocked':
        return AuthStateType.blocked;
      case 'unActivated':
        return AuthStateType.unActivated;
      case 'initial':
        return AuthStateType.initial;
      case 'unAuth':
        return AuthStateType.unAuth;
      default:
        return AuthStateType.initial;
    }
  }
}

extension Ut on AuthStateType {
  String getString() {
    switch (this) {
      case AuthStateType.authenticated:
        return 'authenticated';
      case AuthStateType.blocked:
        return 'blocked';
      case AuthStateType.unActivated:
        return 'unActivated';
      case AuthStateType.initial:
        return 'initial';
      case AuthStateType.unAuth:
        return 'unAuth';
    }
  }
}
