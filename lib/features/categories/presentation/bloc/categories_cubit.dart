import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/family_member_role.dart';
import '../../../../core/error/api_result.dart';
import '../../../family/domain/usecases/get_current_member_usecase.dart';
import '../../../family/domain/usecases/get_user_family_usecase.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/create_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final CreateCategoryUseCase _createCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final GetCurrentMemberUseCase _getCurrentMemberUseCase;
  final GetUserFamilyUseCase _getUserFamilyUseCase;

  String? _familyId;
  bool _canManage = false;
  List<CategoryEntity> _categories = [];

  CategoriesCubit(
    this._getCategoriesUseCase,
    this._createCategoryUseCase,
    this._updateCategoryUseCase,
    this._deleteCategoryUseCase,
    this._getCurrentMemberUseCase,
    this._getUserFamilyUseCase,
  ) : super(const CategoriesInitial());

  Future<void> loadCategories() async {
    emit(const CategoriesLoading());

    final familyResult = await _getUserFamilyUseCase();
    final String familyId;
    switch (familyResult) {
      case ApiSuccess(data: final f) when f != null:
        familyId = f.id;
      case ApiSuccess():
        emit(const CategoriesError('No family found'));
        return;
      case ApiFailure(failure: final error):
        emit(CategoriesError(error.message));
        return;
    }

    final memberResult = await _getCurrentMemberUseCase();
    switch (memberResult) {
      case ApiSuccess(data: final member):
        _canManage = member?.role == FamilyMemberRole.manager ||
            member?.role == FamilyMemberRole.coManager;
      case ApiFailure(failure: final error):
        emit(CategoriesError(error.message));
        return;
    }

    final categoriesResult = await _getCategoriesUseCase(familyId);
    switch (categoriesResult) {
      case ApiSuccess(data: final list):
        _familyId = familyId;
        _categories = list;
        emit(CategoriesLoaded(list, canManage: _canManage));
      case ApiFailure(failure: final error):
        emit(CategoriesError(error.message));
    }
  }

  Future<void> createCategory({
    required String name,
    required String icon,
    required int colorValue,
  }) async {
    final fid = _familyId;
    if (fid == null) {
      emit(const CategoriesError('No family loaded'));
      return;
    }
    if (!_canManage) {
      emit(const CategoriesError('You do not have permission to manage categories'));
      return;
    }

    emit(CategoriesMutating(_categories, canManage: _canManage));

    final result = await _createCategoryUseCase(
      familyId: fid,
      name: name,
      icon: icon,
      colorValue: colorValue,
    );

    switch (result) {
      case ApiSuccess(data: final category):
        _categories = [category, ..._categories];
        emit(CategoriesLoaded(_categories, canManage: _canManage));
      case ApiFailure(failure: final error):
        emit(CategoriesError(error.message));
        emit(CategoriesLoaded(_categories, canManage: _canManage));
    }
  }

  Future<void> updateCategory({
    required String id,
    required String name,
    required String icon,
    required int colorValue,
  }) async {
    if (!_canManage) {
      emit(const CategoriesError('You do not have permission to manage categories'));
      return;
    }

    emit(CategoriesMutating(_categories, canManage: _canManage));

    final result = await _updateCategoryUseCase(
      id: id,
      name: name,
      icon: icon,
      colorValue: colorValue,
    );

    switch (result) {
      case ApiSuccess(data: final updated):
        _categories = _categories
            .map((c) => c.id == updated.id ? updated : c)
            .toList();
        emit(CategoriesLoaded(_categories, canManage: _canManage));
      case ApiFailure(failure: final error):
        emit(CategoriesError(error.message));
        emit(CategoriesLoaded(_categories, canManage: _canManage));
    }
  }

  Future<void> deleteCategory(String id) async {
    if (!_canManage) {
      emit(const CategoriesError('You do not have permission to manage categories'));
      return;
    }

    final target = _categories.where((c) => c.id == id).firstOrNull;
    if (target != null && target.isDefault) {
      emit(const CategoriesError('Default categories cannot be deleted'));
      return;
    }

    emit(CategoriesMutating(_categories, canManage: _canManage));

    final result = await _deleteCategoryUseCase(id);

    switch (result) {
      case ApiSuccess():
        _categories = _categories.where((c) => c.id != id).toList();
        emit(CategoriesLoaded(_categories, canManage: _canManage));
      case ApiFailure(failure: final error):
        emit(CategoriesError(error.message));
        emit(CategoriesLoaded(_categories, canManage: _canManage));
    }
  }
}
