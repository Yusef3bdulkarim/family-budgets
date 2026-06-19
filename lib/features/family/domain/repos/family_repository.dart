import '../../../../core/error/api_result.dart';
import '../entities/family_entity.dart';

abstract class FamilyRepository {
  Future<ApiResult<FamilyEntity>> createFamily(String name);
  Future<ApiResult<FamilyEntity?>> getUserFamily();
}
