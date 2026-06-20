import '../../../../core/constants/category_constants.dart';
import '../../../../core/error/failure.dart';

Failure? validateCategoryInput({
  required String name,
  required String icon,
  required int colorValue,
}) {
  if (name.isEmpty) {
    return const CategoryFailure(message: 'Category name cannot be empty');
  }
  if (name.length > CategoryConstants.maxNameLength) {
    return CategoryFailure(
      message:
          'Category name must be ${CategoryConstants.maxNameLength} characters or fewer',
    );
  }
  if (!CategoryConstants.validIconKeys.contains(icon)) {
    return const CategoryFailure(message: 'Invalid icon selected');
  }
  if (!CategoryConstants.presetColors.contains(colorValue)) {
    return const CategoryFailure(message: 'Invalid color selected');
  }
  return null;
}
