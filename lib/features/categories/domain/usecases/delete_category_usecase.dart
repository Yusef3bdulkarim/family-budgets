import '../../../../core/error/api_result.dart';
import '../repos/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<ApiResult<void>> call(String id) => _repository.deleteCategory(id);
}
