import '../../../../core/error/api_result.dart';
import '../../../../core/error/firebase_error_handler.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repository.dart';
import '../datasources/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  AuthRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _dataSource.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _dataSource.login(email: email, password: password);
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<UserEntity>> signInWithGoogle() async {
    try {
      final user = await _dataSource.signInWithGoogle();
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<UserEntity>> signInWithApple() async {
    try {
      final user = await _dataSource.signInWithApple();
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> forgotPassword({required String email}) async {
    try {
      await _dataSource.forgotPassword(email: email);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> sendEmailVerification() async {
    try {
      await _dataSource.sendEmailVerification();
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> logout() async {
    try {
      await _dataSource.logout();
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<UserEntity?>> getCurrentUser() async {
    try {
      final user = await _dataSource.getCurrentUser();
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }
}
