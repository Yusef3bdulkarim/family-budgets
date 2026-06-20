import '../../../../core/error/api_result.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<ApiResult<List<CategoryEntity>>> getCategories(String familyId);

  Future<ApiResult<CategoryEntity>> createCategory({
    required String familyId,
    required String name,
    required String icon,
    required int colorValue,
  });

  Future<ApiResult<CategoryEntity>> updateCategory({
    required String id,
    required String name,
    required String icon,
    required int colorValue,
  });

  Future<ApiResult<void>> deleteCategory(String id);
}
