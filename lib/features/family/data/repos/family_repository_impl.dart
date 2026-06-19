import '../../../../core/error/api_result.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/firebase_error_handler.dart';
import '../../domain/entities/family_entity.dart';
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
}
