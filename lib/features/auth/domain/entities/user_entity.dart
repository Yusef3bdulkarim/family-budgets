class UserEntity {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final bool emailVerified;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.emailVerified,
  });

  String get fullName => '$firstName $lastName'.trim();
}
