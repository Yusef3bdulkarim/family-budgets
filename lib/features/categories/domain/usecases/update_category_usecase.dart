import '../../../../core/error/api_result.dart';
import '../entities/category_entity.dart';
import '../repos/category_repository.dart';
import '../validators/category_validator.dart';

class UpdateCategoryUseCase {
  final CategoryRepository _repository;

  UpdateCategoryUseCase(this._repository);

  Future<ApiResult<CategoryEntity>> call({
    required String id,
    required String name,
    required String icon,
    required int colorValue,
  }) {
    final trimmed = name.trim();
    final error = validateCategoryInput(
      name: trimmed,
      icon: icon,
      colorValue: colorValue,
    );
    if (error != null) return Future.value(ApiResult.failure(error));

    return _repository.updateCategory(
      id: id,
      name: trimmed,
      icon: icon,
      colorValue: colorValue,
    );
  }
}
