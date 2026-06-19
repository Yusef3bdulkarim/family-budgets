import '../../../../core/error/api_result.dart';
import '../entities/invitation_entity.dart';

abstract class InvitationRepository {
  Future<ApiResult<List<InvitationEntity>>> getPendingInvitations();
  Future<ApiResult<void>> acceptInvitation(InvitationEntity invitation);
  Future<ApiResult<void>> rejectInvitation(InvitationEntity invitation);
  Future<ApiResult<bool>> claimPendingMembershipByEmail();
}
