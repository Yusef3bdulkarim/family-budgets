import '../../domain/entities/family_entity.dart';

sealed class FamilyCreationState {
  const FamilyCreationState();
}

class FamilyCreationInitial extends FamilyCreationState {
  const FamilyCreationInitial();
}

class FamilyCreationChecking extends FamilyCreationState {
  const FamilyCreationChecking();
}

class FamilyCreationReady extends FamilyCreationState {
  const FamilyCreationReady();
}

class FamilyCreationLoading extends FamilyCreationState {
  const FamilyCreationLoading();
}

class FamilyCreationSuccess extends FamilyCreationState {
  final FamilyEntity family;
  const FamilyCreationSuccess(this.family);
}

class FamilyAlreadyExists extends FamilyCreationState {
  final FamilyEntity family;
  const FamilyAlreadyExists(this.family);
}

class FamilyCreationError extends FamilyCreationState {
  final String message;
  const FamilyCreationError(this.message);
}
