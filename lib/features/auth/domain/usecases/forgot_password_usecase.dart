import '../../../../core/error/api_result.dart';
import '../repos/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository _repository;
  ForgotPasswordUseCase(this._repository);

  Future<ApiResult<void>> call({required String email}) =>
      _repository.forgotPassword(email: email);
}
