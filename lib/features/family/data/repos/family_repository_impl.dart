import '../../../../core/error/api_result.dart';
import '../../../../core/error/firebase_error_handler.dart';
import '../../../../core/enums/family_member_role.dart';
import '../../domain/entities/add_member_result.dart';
import '../../domain/entities/family_entity.dart';
import '../../domain/entities/family_member_entity.dart';
import '../../domain/repos/family_repository.dart';
import '../datasources/family_data_source.dart';

class FamilyRepositoryImpl implements FamilyRepository {
  final FamilyDataSource _dataSource;

  FamilyRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<FamilyEntity>> createFamily(String name) async {
    try {
      final family = await _dataSource.createFamily(name);
      return ApiResult.success(family);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<FamilyEntity?>> getUserFamily() async {
    try {
      final family = await _dataSource.getUserFamily();
      return ApiResult.success(family);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<FamilyMemberEntity?>> getCurrentMember() async {
    try {
      final member = await _dataSource.getCurrentMember();
      return ApiResult.success(member);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AddMemberResult>> addMember({
    required String familyId,
    required String displayName,
    required String email,
    required FamilyMemberRole role,
    double? monthlyBudget,
  }) async {
    try {
      final result = await _dataSource.addMember(
        familyId: familyId,
        displayName: displayName,
        email: email,
        role: role,
        monthlyBudget: monthlyBudget,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> updateFamilySettings({
    required String familyId,
    required int budgetStartDay,
    required String currency,
    double? autoApprovalLimit,
  }) async {
    try {
      await _dataSource.updateFamilySettings(
        familyId: familyId,
        budgetStartDay: budgetStartDay,
        currency: currency,
        autoApprovalLimit: autoApprovalLimit,
      );
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }
}
