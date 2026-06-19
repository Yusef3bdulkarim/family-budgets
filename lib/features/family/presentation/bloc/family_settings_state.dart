import '../../domain/entities/family_entity.dart';

sealed class FamilySettingsState {
  const FamilySettingsState();
}

class FamilySettingsInitial extends FamilySettingsState {
  const FamilySettingsInitial();
}

class FamilySettingsLoading extends FamilySettingsState {
  const FamilySettingsLoading();
}

class FamilySettingsLoaded extends FamilySettingsState {
  final FamilyEntity family;
  const FamilySettingsLoaded(this.family);
}

class FamilySettingsSaving extends FamilySettingsState {
  const FamilySettingsSaving();
}

class FamilySettingsSaved extends FamilySettingsState {
  final FamilyEntity family;
  const FamilySettingsSaved(this.family);
}

class FamilySettingsError extends FamilySettingsState {
  final String message;
  const FamilySettingsError(this.message);
}
