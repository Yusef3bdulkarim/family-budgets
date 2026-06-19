import '../../../../core/error/api_result.dart';
import '../repos/auth_repository.dart';

class CheckEmailVerificationUseCase {
  final AuthRepository _repository;
  CheckEmailVerificationUseCase(this._repository);

  Future<ApiResult<bool>> call() => _repository.checkEmailVerification();
}
