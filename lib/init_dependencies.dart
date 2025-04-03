import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vietour/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:vietour/core/secrets/app_secrets.dart';
import 'package:vietour/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vietour/features/auth/data/repositories/auth_repository_imlp.dart';
import 'package:vietour/features/auth/domain/repository/auth_repository.dart';
import 'package:vietour/features/auth/domain/usercases/current_user.dart';
import 'package:vietour/features/auth/domain/usercases/user_google_sign_in.dart';
import 'package:vietour/features/auth/domain/usercases/user_login.dart';
import 'package:vietour/features/auth/domain/usercases/user_logout.dart';
import 'package:vietour/features/auth/domain/usercases/user_sign_up.dart';
import 'package:vietour/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vietour/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:vietour/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:vietour/features/blog/domain/repositories/blog_repository.dart';
import 'package:vietour/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:vietour/features/blog/domain/usecases/upload_blog.dart';
import 'package:vietour/features/blog/persentation/bloc/blog_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initdependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );

  //core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  //Datasources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    //Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImlp(serviceLocator()),
    )
    //Use cases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerFactory(
      () => UserGoogleSignIn(serviceLocator()),
    )
    ..registerFactory(() => UserLogout(serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userGoogleSignIn: serviceLocator(),
        userLogOut: serviceLocator(),
      ),
    );
}

void _initBlog() {
  //Datasources
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    //Repositories
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    //Use cases
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
