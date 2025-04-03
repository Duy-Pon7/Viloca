import 'package:fpdart/fpdart.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/core/usercase/usecase.dart';
import 'package:vietour/features/auth/domain/repository/auth_repository.dart';

class UserLogout implements Usecase<void, NoParams> {
  // Change the return type to void and parameter to NoParams
  final AuthRepository authRepository;
  const UserLogout(this.authRepository);

  @override
  Future<Either<Failure, void>> call(
    NoParams params, // Accept NoParams
  ) async {
    return await authRepository
        .logout(); // Call the logout method from the repository
  }
}
