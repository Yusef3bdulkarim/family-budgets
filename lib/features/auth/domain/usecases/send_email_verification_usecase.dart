import '../../../../core/error/api_result.dart';
import '../repos/auth_repository.dart';

class SendEmailVerificationUseCase {
  final AuthRepository _repository;
  SendEmailVerificationUseCase(this._repository);

  Future<ApiResult<void>> call() => _repository.sendEmailVerification();
}
