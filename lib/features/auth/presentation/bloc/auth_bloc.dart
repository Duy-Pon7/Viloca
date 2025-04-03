import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietour/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:vietour/core/usercase/usecase.dart';
import 'package:vietour/core/common/entities/user.dart';
import 'package:vietour/features/auth/domain/usercases/current_user.dart';
import 'package:vietour/features/auth/domain/usercases/user_google_sign_in.dart';
import 'package:vietour/features/auth/domain/usercases/user_login.dart';
import 'package:vietour/features/auth/domain/usercases/user_logout.dart';
import 'package:vietour/features/auth/domain/usercases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// Bloc quản lý trạng thái xác thực (đăng nhập, đăng ký, đăng xuất).
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserGoogleSignIn
  _userGoogleSignIn; // Thêm UseCase cho Google Sign-In
  final UserLogout _userLogOut;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserGoogleSignIn
    userGoogleSignIn, // Thêm vào constructor
    required UserLogout userLogOut,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       _userGoogleSignIn =
           userGoogleSignIn, // Thêm vào constructor
       _userLogOut = userLogOut,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthGoogleSignIn>(
      _onAuthGoogleSignIn,
    ); // Thêm sự kiện Google Sign-In
    on<AuthLogout>(_onAuthLogOut);
  }

  void _onAuthLogOut(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    // Assuming UserLogout expects NoParams
    final res = await _userLogOut(
      NoParams(),
    ); // NoParams is correct for logout
    res.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ), // If failed, show error
      (_) {
        _appUserCubit
            .logout(); // Logout user and update state in cubit
        emit(
          AuthLoggedOut(),
        ); // Emit successful logout state
      },
    );
  }

  // Hàm xử lý đăng nhập qua Google
  void _onAuthGoogleSignIn(
    AuthGoogleSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userGoogleSignIn(NoParams());
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        print(
          "DEBUG: Google Sign-In thành công - User: ${user.email}",
        );
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignup(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
