import '../../../../core/error/api_result.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repository.dart';

class AppleSignInUseCase {
  final AuthRepository _repository;
  AppleSignInUseCase(this._repository);

  Future<ApiResult<UserEntity>> call() => _repository.signInWithApple();
}
