import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/category_constants.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.familyId,
    required super.name,
    required super.icon,
    required super.colorValue,
    required super.isDefault,
    required super.isDeleted,
    required super.createdAt,
  });

  factory CategoryModel.fromFirestore(String docId, Map<String, dynamic> data) {
    final rawIcon = data['icon'] as String? ?? CategoryConstants.defaultIcon;
    final icon = CategoryConstants.validIconKeys.contains(rawIcon)
        ? rawIcon
        : CategoryConstants.defaultIcon;

    final rawColor = (data['colorValue'] as int?);
    final colorValue = rawColor != null &&
            CategoryConstants.presetColors.contains(rawColor)
        ? rawColor
        : CategoryConstants.defaultColor;

    return CategoryModel(
      id: docId,
      familyId: data['familyId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      icon: icon,
      colorValue: colorValue,
      isDefault: data['isDefault'] as bool? ?? false,
      isDeleted: data['isDeleted'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'familyId': familyId,
        'name': name,
        'icon': icon,
        'colorValue': colorValue,
        'isDefault': isDefault,
        'isDeleted': isDeleted,
      };
}
