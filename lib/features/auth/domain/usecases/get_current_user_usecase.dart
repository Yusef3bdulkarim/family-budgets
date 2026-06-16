import '../../../../core/error/api_result.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;
  GetCurrentUserUseCase(this._repository);

  Future<ApiResult<UserEntity?>> call() => _repository.getCurrentUser();
}
