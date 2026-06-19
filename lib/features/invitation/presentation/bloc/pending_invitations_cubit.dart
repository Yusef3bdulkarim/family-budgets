import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/invitation_entity.dart';
import '../../domain/usecases/check_pending_invitations_usecase.dart';
import '../../domain/usecases/respond_to_invitation_usecase.dart';
import 'pending_invitations_state.dart';

class PendingInvitationsCubit extends Cubit<PendingInvitationsState> {
  final CheckPendingInvitationsUseCase _checkPendingUseCase;
  final RespondToInvitationUseCase _respondUseCase;

  PendingInvitationsCubit(this._checkPendingUseCase, this._respondUseCase)
      : super(const PendingInvitationsInitial());

  Future<void> loadInvitations() async {
    emit(const PendingInvitationsLoading());

    final result = await _checkPendingUseCase();

    result.when(
      success: (invitations) {
        if (invitations.isEmpty) {
          emit(const PendingInvitationsEmpty());
        } else {
          emit(PendingInvitationsLoaded(invitations));
        }
      },
      failure: (error) => emit(PendingInvitationsError(error.message)),
    );
  }

  Future<void> accept(InvitationEntity invitation) async {
    final currentInvitations = _currentInvitations;
    emit(InvitationResponding(currentInvitations, invitation.id));

    final result = await _respondUseCase.accept(invitation);

    result.when(
      success: (_) => emit(const InvitationAccepted()),
      failure: (error) => emit(
        PendingInvitationsError(error.message, invitations: currentInvitations),
      ),
    );
  }

  Future<void> reject(InvitationEntity invitation) async {
    final currentInvitations = _currentInvitations;
    emit(InvitationResponding(currentInvitations, invitation.id));

    final result = await _respondUseCase.reject(invitation);

    result.when(
      success: (_) {
        final remaining =
            currentInvitations.where((i) => i.id != invitation.id).toList();
        if (remaining.isEmpty) {
          emit(const PendingInvitationsEmpty());
        } else {
          emit(InvitationRejected(remaining));
        }
      },
      failure: (error) => emit(
        PendingInvitationsError(error.message, invitations: currentInvitations),
      ),
    );
  }

  List<InvitationEntity> get _currentInvitations => switch (state) {
        PendingInvitationsLoaded(:final invitations) => invitations,
        InvitationResponding(:final invitations) => invitations,
        InvitationRejected(:final remainingInvitations) =>
          remainingInvitations,
        PendingInvitationsError(:final invitations) => invitations,
        _ => const [],
      };
}
