import '../../../../core/constants/family_constants.dart';
import '../../../../core/error/api_result.dart';
import '../../../../core/error/failure.dart';
import '../repos/family_repository.dart';

class UpdateFamilySettingsUseCase {
  final FamilyRepository _repository;

  UpdateFamilySettingsUseCase(this._repository);

  Future<ApiResult<void>> call({
    required String familyId,
    required int budgetStartDay,
    required String currency,
    double? autoApprovalLimit,
  }) {
    if (budgetStartDay < FamilyConstants.minBudgetStartDay ||
        budgetStartDay > FamilyConstants.maxBudgetStartDay) {
      return Future.value(ApiResult.failure(
        const FamilyFailure(message: 'Budget start day must be between 1 and 28'),
      ));
    }
    if (!FamilyConstants.supportedCurrencies.contains(currency)) {
      return Future.value(ApiResult.failure(
        const FamilyFailure(message: 'Unsupported currency'),
      ));
    }
    if (autoApprovalLimit != null &&
        (autoApprovalLimit <= 0 ||
            autoApprovalLimit > FamilyConstants.maxAutoApprovalLimit)) {
      return Future.value(ApiResult.failure(
        const FamilyFailure(message: 'Auto-approval limit must be between 0 and 1,000,000'),
      ));
    }
    return _repository.updateFamilySettings(
      familyId: familyId,
      budgetStartDay: budgetStartDay,
      currency: currency,
      autoApprovalLimit: autoApprovalLimit,
    );
  }
}
