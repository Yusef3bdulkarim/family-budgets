import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.emailVerified,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> json, {
    required String uid,
    required bool emailVerified,
  }) {
    return UserModel(
      uid: uid,
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      emailVerified: emailVerified,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      };
}
