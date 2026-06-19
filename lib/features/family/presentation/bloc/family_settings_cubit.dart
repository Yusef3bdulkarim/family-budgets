import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/api_result.dart';
import '../../../auth/domain/usecases/get_current_user_usecase.dart';
import '../../domain/entities/family_entity.dart';
import '../../domain/usecases/get_user_family_usecase.dart';
import '../../domain/usecases/update_family_settings_usecase.dart';
import 'family_settings_state.dart';

class FamilySettingsCubit extends Cubit<FamilySettingsState> {
  final GetUserFamilyUseCase _getUserFamilyUseCase;
  final UpdateFamilySettingsUseCase _updateFamilySettingsUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  FamilyEntity? _loadedFamily;

  FamilySettingsCubit(
    this._getUserFamilyUseCase,
    this._updateFamilySettingsUseCase,
    this._getCurrentUserUseCase,
  ) : super(const FamilySettingsInitial());

  Future<void> loadSettings() async {
    emit(const FamilySettingsLoading());

    final familyResult = await _getUserFamilyUseCase();
    final FamilyEntity family;
    switch (familyResult) {
      case ApiSuccess(data: final f) when f != null:
        family = f;
      case ApiSuccess():
        emit(const FamilySettingsError('Family not found'));
        return;
      case ApiFailure(failure: final error):
        emit(FamilySettingsError(error.message));
        return;
    }

    final userResult = await _getCurrentUserUseCase();
    switch (userResult) {
      case ApiSuccess(data: final user)
          when user != null && user.uid == family.managerId:
        _loadedFamily = family;
        emit(FamilySettingsLoaded(family));
      case ApiSuccess():
        emit(const FamilySettingsError(
          'Only the family manager can edit these settings',
        ));
      case ApiFailure(failure: final error):
        emit(FamilySettingsError(error.message));
    }
  }

  Future<void> saveSettings({
    required String familyId,
    required int budgetStartDay,
    required String currency,
    double? autoApprovalLimit,
  }) async {
    final cached = _loadedFamily;
    if (cached == null) {
      emit(const FamilySettingsError('Settings not loaded. Please reload the screen.'));
      return;
    }

    emit(const FamilySettingsSaving());
    final result = await _updateFamilySettingsUseCase(
      familyId: familyId,
      budgetStartDay: budgetStartDay,
      currency: currency,
      autoApprovalLimit: autoApprovalLimit,
    );
    switch (result) {
      case ApiSuccess():
        final updated = FamilyEntity(
          id: cached.id,
          name: cached.name,
          managerId: cached.managerId,
          createdAt: cached.createdAt,
          budgetStartDay: budgetStartDay,
          currency: currency,
          autoApprovalLimit: autoApprovalLimit,
        );
        _loadedFamily = updated;
        emit(FamilySettingsSaved(updated));
      case ApiFailure(failure: final error):
        emit(FamilySettingsError(error.message));
        emit(FamilySettingsLoaded(_loadedFamily!));
    }
  }
}
