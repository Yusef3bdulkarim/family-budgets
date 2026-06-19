enum FamilyMemberRole {
  manager,
  coManager,
  familyMember;

  String toJson() => switch (this) {
        FamilyMemberRole.manager => 'manager',
        FamilyMemberRole.coManager => 'coManager',
        FamilyMemberRole.familyMember => 'familyMember',
      };

  static FamilyMemberRole fromJson(String value) => switch (value) {
        'manager' => FamilyMemberRole.manager,
        'coManager' => FamilyMemberRole.coManager,
        _ => FamilyMemberRole.familyMember,
      };

  String get displayName => switch (this) {
        FamilyMemberRole.manager => 'Manager',
        FamilyMemberRole.coManager => 'Co-Manager',
        FamilyMemberRole.familyMember => 'Family Member',
      };
}
