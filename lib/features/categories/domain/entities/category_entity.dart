class CategoryEntity {
  final String id;
  final String familyId;
  final String name;
  final String icon;
  final int colorValue;
  final bool isDefault;
  final bool isDeleted;
  final DateTime createdAt;

  const CategoryEntity({
    required this.id,
    required this.familyId,
    required this.name,
    required this.icon,
    required this.colorValue,
    required this.isDefault,
    required this.isDeleted,
    required this.createdAt,
  });
}
