import '../../domain/entities/invitation_entity.dart';

sealed class PendingInvitationsState {
  const PendingInvitationsState();
}

class PendingInvitationsInitial extends PendingInvitationsState {
  const PendingInvitationsInitial();
}

class PendingInvitationsLoading extends PendingInvitationsState {
  const PendingInvitationsLoading();
}

class PendingInvitationsLoaded extends PendingInvitationsState {
  final List<InvitationEntity> invitations;
  const PendingInvitationsLoaded(this.invitations);
}

class PendingInvitationsEmpty extends PendingInvitationsState {
  const PendingInvitationsEmpty();
}

class InvitationResponding extends PendingInvitationsState {
  final List<InvitationEntity> invitations;
  final String respondingId;
  const InvitationResponding(this.invitations, this.respondingId);
}

class InvitationAccepted extends PendingInvitationsState {
  const InvitationAccepted();
}

class InvitationRejected extends PendingInvitationsState {
  final List<InvitationEntity> remainingInvitations;
  const InvitationRejected(this.remainingInvitations);
}

class PendingInvitationsError extends PendingInvitationsState {
  final String message;
  final List<InvitationEntity> invitations;
  const PendingInvitationsError(this.message, {this.invitations = const []});
}
