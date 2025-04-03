import 'package:fpdart/fpdart.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/core/usercase/usecase.dart';
import 'package:vietour/core/common/entities/user.dart';
import 'package:vietour/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(
    UserLoginParams params,
  ) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
