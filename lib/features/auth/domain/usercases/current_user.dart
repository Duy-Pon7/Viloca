import 'package:fpdart/fpdart.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/core/common/entities/user.dart';
import 'package:vietour/core/usercase/usecase.dart';
import 'package:vietour/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(
    NoParams params,
  ) async {
    return await authRepository.currentUser();
  }
}
