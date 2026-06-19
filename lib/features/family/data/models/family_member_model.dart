import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/enums/family_member_role.dart';
import '../../domain/entities/family_member_entity.dart';

class FamilyMemberModel extends FamilyMemberEntity {
  const FamilyMemberModel({
    required super.id,
    required super.familyId,
    super.userId,
    required super.displayName,
    required super.email,
    required super.role,
    required super.status,
    super.monthlyBudget,
    super.joinedAt,
  });

  factory FamilyMemberModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return FamilyMemberModel(
      id: docId,
      familyId: data['familyId'] as String? ?? '',
      userId: data['userId'] as String?,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: FamilyMemberRole.fromJson(data['role'] as String? ?? ''),
      status: data['status'] as String? ?? 'pending',
      monthlyBudget: (data['monthlyBudget'] as num?)?.toDouble(),
      joinedAt: (data['joinedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'familyId': familyId,
        'userId': userId,
        'displayName': displayName,
        'email': email,
        'role': role.toJson(),
        'status': status,
        'monthlyBudget': monthlyBudget,
        'joinedAt': joinedAt != null ? Timestamp.fromDate(joinedAt!) : null,
      };
}
