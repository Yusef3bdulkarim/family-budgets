import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/enums/family_member_role.dart';
import '../../domain/entities/invitation_entity.dart';

class InvitationModel extends InvitationEntity {
  const InvitationModel({
    required super.id,
    required super.familyId,
    required super.familyName,
    required super.senderId,
    required super.senderName,
    required super.recipientId,
    required super.recipientEmail,
    required super.pendingMemberId,
    required super.displayName,
    required super.role,
    super.monthlyBudget,
    required super.status,
    required super.createdAt,
  });

  factory InvitationModel.fromFirestore(
      String docId, Map<String, dynamic> data) {
    return InvitationModel(
      id: docId,
      familyId: data['familyId'] as String? ?? '',
      familyName: data['familyName'] as String? ?? '',
      senderId: data['senderId'] as String? ?? '',
      senderName: data['senderName'] as String? ?? '',
      recipientId: data['recipientId'] as String? ?? '',
      recipientEmail: data['recipientEmail'] as String? ?? '',
      pendingMemberId: data['pendingMemberId'] as String? ?? '',
      displayName: data['displayName'] as String? ?? '',
      role: FamilyMemberRole.fromJson(data['role'] as String? ?? ''),
      monthlyBudget: (data['monthlyBudget'] as num?)?.toDouble(),
      status: data['status'] as String? ?? 'pending',
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'familyId': familyId,
        'familyName': familyName,
        'senderId': senderId,
        'senderName': senderName,
        'recipientId': recipientId,
        'recipientEmail': recipientEmail,
        'pendingMemberId': pendingMemberId,
        'displayName': displayName,
        'role': role.toJson(),
        'monthlyBudget': monthlyBudget,
        'status': status,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
