import 'family_member_entity.dart';

enum InviteStatus {
  sent,
  userNotFound,
}

class AddMemberResult {
  final FamilyMemberEntity member;
  final InviteStatus inviteStatus;

  const AddMemberResult({required this.member, required this.inviteStatus});
}
