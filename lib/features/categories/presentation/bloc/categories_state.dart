import '../../domain/entities/category_entity.dart';

sealed class CategoriesState {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;
  final bool canManage;

  const CategoriesLoaded(this.categories, {required this.canManage});
}

class CategoriesMutating extends CategoriesState {
  final List<CategoryEntity> categories;
  final bool canManage;

  const CategoriesMutating(this.categories, {required this.canManage});
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);
}
