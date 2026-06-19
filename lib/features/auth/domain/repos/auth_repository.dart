import '../../../../core/error/api_result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<ApiResult<UserEntity>> login({
    required String email,
    required String password,
  });

  Future<ApiResult<UserEntity>> signInWithGoogle();

  Future<ApiResult<UserEntity>> signInWithApple();

  Future<ApiResult<void>> forgotPassword({required String email});

  Future<ApiResult<void>> sendEmailVerification();

  Future<ApiResult<bool>> checkEmailVerification();

  Future<ApiResult<void>> logout();

  Future<ApiResult<UserEntity?>> getCurrentUser();
}
