import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/auth/data/datasources/auth_data_source.dart';
import '../../features/auth/data/repos/auth_repository_impl.dart';
import '../../features/auth/domain/repos/auth_repository.dart';
import '../../features/auth/domain/usecases/apple_sign_in_usecase.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/google_sign_in_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/send_email_verification_usecase.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Firebase
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => GoogleSignIn());

  // Auth — DataSource
  getIt.registerLazySingleton(
    () => AuthDataSource(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>(),
      getIt<GoogleSignIn>(),
    ),
  );

  // Auth — Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDataSource>()),
  );

  // Auth — Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
      () => GoogleSignInUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
      () => AppleSignInUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
      () => ForgotPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
      () => GetCurrentUserUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
      () => SendEmailVerificationUseCase(getIt<AuthRepository>()));

  // Auth — Cubit
  getIt.registerFactory(
    () => AuthCubit(
      getIt<LoginUseCase>(),
      getIt<RegisterUseCase>(),
      getIt<GoogleSignInUseCase>(),
      getIt<AppleSignInUseCase>(),
      getIt<ForgotPasswordUseCase>(),
      getIt<LogoutUseCase>(),
      getIt<SendEmailVerificationUseCase>(),
    ),
  );
}
