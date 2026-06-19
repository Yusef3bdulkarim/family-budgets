import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/apple_sign_in_usecase.dart';
import '../../domain/usecases/check_email_verification_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/google_sign_in_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/send_email_verification_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final AppleSignInUseCase _appleSignInUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final LogoutUseCase _logoutUseCase;
  final SendEmailVerificationUseCase _sendEmailVerificationUseCase;
  final CheckEmailVerificationUseCase _checkEmailVerificationUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GoogleSignInUseCase googleSignInUseCase,
    required AppleSignInUseCase appleSignInUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required LogoutUseCase logoutUseCase,
    required SendEmailVerificationUseCase sendEmailVerificationUseCase,
    required CheckEmailVerificationUseCase checkEmailVerificationUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _googleSignInUseCase = googleSignInUseCase,
        _appleSignInUseCase = appleSignInUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _logoutUseCase = logoutUseCase,
        _sendEmailVerificationUseCase = sendEmailVerificationUseCase,
        _checkEmailVerificationUseCase = checkEmailVerificationUseCase,
        super(const AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await _loginUseCase(email: email, password: password);
    result.when(
      success: (user) => emit(AuthSuccess(user)),
      failure: (error) => emit(AuthError(error.message)),
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _registerUseCase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    result.when(
      success: (user) => emit(AuthSuccess(user)),
      failure: (error) => emit(AuthError(error.message)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());
    final result = await _googleSignInUseCase();
    result.when(
      success: (user) => emit(AuthSuccess(user)),
      failure: (error) => emit(AuthError(error.message)),
    );
  }

  Future<void> signInWithApple() async {
    emit(const AuthLoading());
    final result = await _appleSignInUseCase();
    result.when(
      success: (user) => emit(AuthSuccess(user)),
      failure: (error) => emit(AuthError(error.message)),
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(const AuthLoading());
    final result = await _forgotPasswordUseCase(email: email);
    result.when(
      success: (_) => emit(const AuthPasswordResetSent()),
      failure: (error) => emit(AuthError(error.message)),
    );
  }

  Future<void> sendEmailVerification() async {
    emit(const AuthLoading());
    final result = await _sendEmailVerificationUseCase();
    result.when(
      success: (_) => emit(const AuthEmailVerificationSent()),
      failure: (error) => emit(AuthError(error.message)),
    );
  }

  Future<void> checkEmailVerification() async {
    final result = await _checkEmailVerificationUseCase();
    result.when(
      success: (isVerified) {
        if (isVerified) {
          emit(const AuthEmailVerified());
        } else if (state is! AuthEmailVerificationSent) {
          emit(const AuthEmailVerificationSent());
        }
      },
      failure: (error) => emit(AuthError(error.message)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    final result = await _logoutUseCase();
    result.when(
      success: (_) => emit(const AuthLoggedOut()),
      failure: (error) => emit(AuthError(error.message)),
    );
  }
}
