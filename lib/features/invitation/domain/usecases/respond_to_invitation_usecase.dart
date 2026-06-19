import '../../../../core/error/api_result.dart';
import '../entities/invitation_entity.dart';
import '../repos/invitation_repository.dart';

class RespondToInvitationUseCase {
  final InvitationRepository _repository;

  RespondToInvitationUseCase(this._repository);

  Future<ApiResult<void>> accept(InvitationEntity invitation) =>
      _repository.acceptInvitation(invitation);

  Future<ApiResult<void>> reject(InvitationEntity invitation) =>
      _repository.rejectInvitation(invitation);
}
