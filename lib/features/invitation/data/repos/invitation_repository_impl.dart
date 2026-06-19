import '../../../../core/error/api_result.dart';
import '../../../../core/error/firebase_error_handler.dart';
import '../../domain/entities/invitation_entity.dart';
import '../../domain/repos/invitation_repository.dart';
import '../datasources/invitation_data_source.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  final InvitationDataSource _dataSource;

  InvitationRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<List<InvitationEntity>>> getPendingInvitations() async {
    try {
      final invitations = await _dataSource.getPendingInvitations();
      return ApiResult.success(invitations);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> acceptInvitation(InvitationEntity invitation) async {
    try {
      await _dataSource.acceptInvitation(invitation);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> rejectInvitation(InvitationEntity invitation) async {
    try {
      await _dataSource.rejectInvitation(invitation);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> claimPendingMembershipByEmail() async {
    try {
      final claimed = await _dataSource.claimPendingMembershipByEmail();
      return ApiResult.success(claimed);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }
}
