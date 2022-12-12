class SplashState {
  bool? isLogged;

  SplashState({
    required this.isLogged,
  });

  static initialState() {
    return SplashState(
      isLogged: null,
    );
  }

  static userLogged() {
    return SplashState(isLogged: true);
  }

  static userNotLogged() {
    return SplashState(isLogged: false);
  }
}
