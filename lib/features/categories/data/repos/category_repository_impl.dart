import '../../../../core/error/api_result.dart';
import '../../../../core/error/firebase_error_handler.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repos/category_repository.dart';
import '../datasources/category_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource _dataSource;

  CategoryRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories(String familyId) async {
    try {
      final categories = await _dataSource.getCategories(familyId);
      return ApiResult.success(categories);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<CategoryEntity>> createCategory({
    required String familyId,
    required String name,
    required String icon,
    required int colorValue,
  }) async {
    try {
      final category = await _dataSource.createCategory(
        familyId: familyId,
        name: name,
        icon: icon,
        colorValue: colorValue,
      );
      return ApiResult.success(category);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<CategoryEntity>> updateCategory({
    required String id,
    required String name,
    required String icon,
    required int colorValue,
  }) async {
    try {
      final category = await _dataSource.updateCategory(
        id: id,
        name: name,
        icon: icon,
        colorValue: colorValue,
      );
      return ApiResult.success(category);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteCategory(String id) async {
    try {
      await _dataSource.deleteCategory(id);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(FirebaseErrorHandler.handle(e));
    }
  }
}
