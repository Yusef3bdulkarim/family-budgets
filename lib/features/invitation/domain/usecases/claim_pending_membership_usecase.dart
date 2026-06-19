import '../../../../core/error/api_result.dart';
import '../repos/invitation_repository.dart';

class ClaimPendingMembershipUseCase {
  final InvitationRepository _repository;

  ClaimPendingMembershipUseCase(this._repository);

  Future<ApiResult<bool>> call() => _repository.claimPendingMembershipByEmail();
}
