import '../../../../core/error/api_result.dart';
import '../repos/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);

  Future<ApiResult<void>> call() => _repository.logout();
}
