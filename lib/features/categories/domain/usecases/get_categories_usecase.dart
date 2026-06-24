import '../../../../core/error/api_result.dart';
import '../entities/category_entity.dart';
import '../repos/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<ApiResult<List<CategoryEntity>>> call(String familyId) =>
      _repository.getCategories(familyId);
}
