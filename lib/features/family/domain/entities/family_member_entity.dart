import '../../../../core/enums/family_member_role.dart';

class FamilyMemberEntity {
  final String id;
  final String familyId;
  final String? userId;
  final String displayName;
  final String email;
  final FamilyMemberRole role;
  final String status;
  final double? monthlyBudget;
  final DateTime? joinedAt;

  const FamilyMemberEntity({
    required this.id,
    required this.familyId,
    this.userId,
    required this.displayName,
    required this.email,
    required this.role,
    required this.status,
    this.monthlyBudget,
    this.joinedAt,
  });

  bool get isActive => status == 'active';
  bool get isPending => status == 'pending';
}
