import 'package:fpdart/fpdart.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/core/common/entities/user.dart';

// Interface (hợp đồng) để xác định các chức năng liên quan đến xác thực (auth).
abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
  Future<Either<Failure, User>> googleSignIn();
  Future<Either<Failure, User>> logout();
}
