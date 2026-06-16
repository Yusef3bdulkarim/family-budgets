import '../../../../core/error/api_result.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<ApiResult<UserEntity>> call({
    required String email,
    required String password,
  }) =>
      _repository.login(email: email, password: password);
}
