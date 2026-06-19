import '../../../../core/constants/family_constants.dart';

class FamilyEntity {
  final String id;
  final String name;
  final String managerId;
  final DateTime createdAt;
  final int budgetStartDay;
  final String currency;
  final double? autoApprovalLimit;

  const FamilyEntity({
    required this.id,
    required this.name,
    required this.managerId,
    required this.createdAt,
    this.budgetStartDay = FamilyConstants.minBudgetStartDay,
    this.currency = FamilyConstants.defaultCurrency,
    this.autoApprovalLimit,
  });
}
