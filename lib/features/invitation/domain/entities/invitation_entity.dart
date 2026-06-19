import '../../../../core/enums/family_member_role.dart';

class InvitationEntity {
  final String id;
  final String familyId;
  final String familyName;
  final String senderId;
  final String senderName;
  final String recipientId;
  final String recipientEmail;
  final String pendingMemberId;
  final String displayName;
  final FamilyMemberRole role;
  final double? monthlyBudget;
  final String status;
  final DateTime createdAt;

  const InvitationEntity({
    required this.id,
    required this.familyId,
    required this.familyName,
    required this.senderId,
    required this.senderName,
    required this.recipientId,
    required this.recipientEmail,
    required this.pendingMemberId,
    required this.displayName,
    required this.role,
    this.monthlyBudget,
    required this.status,
    required this.createdAt,
  });

  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted';
  bool get isRejected => status == 'rejected';
}
