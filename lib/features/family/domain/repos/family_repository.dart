import '../../../../core/error/api_result.dart';
import '../../../../core/enums/family_member_role.dart';
import '../entities/add_member_result.dart';
import '../entities/family_entity.dart';

abstract class FamilyRepository {
  Future<ApiResult<FamilyEntity>> createFamily(String name);
  Future<ApiResult<FamilyEntity?>> getUserFamily();
  Future<ApiResult<AddMemberResult>> addMember({
    required String familyId,
    required String displayName,
    required String email,
    required FamilyMemberRole role,
    double? monthlyBudget,
  });
}
