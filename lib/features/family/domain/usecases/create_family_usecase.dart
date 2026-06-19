import '../../../../core/error/api_result.dart';
import '../entities/family_entity.dart';
import '../repos/family_repository.dart';

class CreateFamilyUseCase {
  final FamilyRepository _repository;

  CreateFamilyUseCase(this._repository);

  Future<ApiResult<FamilyEntity>> call(String name) =>
      _repository.createFamily(name);
}
