import '../../../../core/error/api_result.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository _repository;
  GoogleSignInUseCase(this._repository);

  Future<ApiResult<UserEntity>> call() => _repository.signInWithGoogle();
}
