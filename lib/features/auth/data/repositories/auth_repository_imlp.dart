import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    as sb;
import 'package:vietour/core/error/exceptions.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vietour/core/common/entities/user.dart';
import 'package:vietour/features/auth/domain/repository/auth_repository.dart';

// Cài đặt của AuthRepository, xử lý logic dữ liệu
class AuthRepositoryImlp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImlp(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> googleSignIn() async {
    return _getUser(
      () async => await remoteDataSource.googleSignIn(),
    );
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user =
          await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async =>
          await remoteDataSource.loginWithEmailAndPassword(
            email: email,
            password: password,
          ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    return _getUser(
      () async =>
          await remoteDataSource.signUpWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> logout() async {
    try {
      final user = await remoteDataSource.logout();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
