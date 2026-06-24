import '../../../../core/error/api_result.dart';
import '../entities/category_entity.dart';
import '../repos/category_repository.dart';
import '../validators/category_validator.dart';

class CreateCategoryUseCase {
  final CategoryRepository _repository;

  CreateCategoryUseCase(this._repository);

  Future<ApiResult<CategoryEntity>> call({
    required String familyId,
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

    return _repository.createCategory(
      familyId: familyId,
      name: trimmed,
      icon: icon,
      colorValue: colorValue,
    );
  }
}
