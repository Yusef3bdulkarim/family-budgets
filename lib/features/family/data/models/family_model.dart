import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/family_entity.dart';

class FamilyModel extends FamilyEntity {
  const FamilyModel({
    required super.id,
    required super.name,
    required super.managerId,
    required super.createdAt,
  });

  factory FamilyModel.fromFirestore(Map<String, dynamic> data) {
    return FamilyModel(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      managerId: data['managerId'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'managerId': managerId,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
