import '../../../../core/error/api_result.dart';
import '../entities/invitation_entity.dart';
import '../repos/invitation_repository.dart';

class CheckPendingInvitationsUseCase {
  final InvitationRepository _repository;

  CheckPendingInvitationsUseCase(this._repository);

  Future<ApiResult<List<InvitationEntity>>> call() =>
      _repository.getPendingInvitations();
}
