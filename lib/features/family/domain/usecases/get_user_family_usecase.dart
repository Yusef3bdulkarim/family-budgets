import '../../../../core/error/api_result.dart';
import '../entities/family_entity.dart';
import '../repos/family_repository.dart';

class GetUserFamilyUseCase {
  final FamilyRepository _repository;

  GetUserFamilyUseCase(this._repository);

  Future<ApiResult<FamilyEntity?>> call() => _repository.getUserFamily();
}
