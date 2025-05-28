part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}
// Trạng thái của quá trình xác thực (thành công, thất bại, đang tải...).

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

class AuthLoggedOut extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
