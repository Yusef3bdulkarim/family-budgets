import '../../../../core/error/api_result.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;
  RegisterUseCase(this._repository);

  Future<ApiResult<UserEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) =>
      _repository.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
}
