import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/family_constants.dart';
import '../../domain/entities/family_entity.dart';

class FamilyModel extends FamilyEntity {
  const FamilyModel({
    required super.id,
    required super.name,
    required super.managerId,
    required super.createdAt,
    super.budgetStartDay,
    super.currency,
    super.autoApprovalLimit,
  });

  factory FamilyModel.fromFirestore(Map<String, dynamic> data) {
    final rawCurrency = data['currency'] as String? ?? FamilyConstants.defaultCurrency;
    return FamilyModel(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      managerId: data['managerId'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      budgetStartDay: (data['budgetStartDay'] as int?) ?? FamilyConstants.minBudgetStartDay,
      currency: FamilyConstants.supportedCurrencies.contains(rawCurrency)
          ? rawCurrency
          : FamilyConstants.defaultCurrency,
      autoApprovalLimit: (data['autoApprovalLimit'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'managerId': managerId,
        'createdAt': FieldValue.serverTimestamp(),
        'budgetStartDay': budgetStartDay,
        'currency': currency,
        'autoApprovalLimit': autoApprovalLimit,
      };
}
