part of 'auth_bloc.dart';

// Các sự kiện liên quan đến xác thực (đăng nhập, đăng ký).
@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthGoogleSignIn extends AuthEvent {}

final class AuthLogout extends AuthEvent {}
