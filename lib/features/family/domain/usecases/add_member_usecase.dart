import '../../../../core/enums/family_member_role.dart';
import '../../../../core/error/api_result.dart';
import '../entities/add_member_result.dart';
import '../repos/family_repository.dart';

class AddMemberUseCase {
  final FamilyRepository _repository;

  AddMemberUseCase(this._repository);

  Future<ApiResult<AddMemberResult>> call({
    required String familyId,
    required String displayName,
    required String email,
    required FamilyMemberRole role,
    double? monthlyBudget,
  }) =>
      _repository.addMember(
        familyId: familyId,
        displayName: displayName,
        email: email,
        role: role,
        monthlyBudget: monthlyBudget,
      );
}
