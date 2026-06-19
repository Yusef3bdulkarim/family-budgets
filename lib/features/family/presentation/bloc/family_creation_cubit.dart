import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/api_result.dart';
import '../../../invitation/domain/usecases/check_pending_invitations_usecase.dart';
import '../../domain/usecases/create_family_usecase.dart';
import '../../domain/usecases/get_user_family_usecase.dart';
import 'family_creation_state.dart';

class FamilyCreationCubit extends Cubit<FamilyCreationState> {
  final CreateFamilyUseCase _createFamilyUseCase;
  final GetUserFamilyUseCase _getUserFamilyUseCase;
  final CheckPendingInvitationsUseCase _checkPendingInvitationsUseCase;

  FamilyCreationCubit(
    this._createFamilyUseCase,
    this._getUserFamilyUseCase,
    this._checkPendingInvitationsUseCase,
  ) : super(const FamilyCreationInitial());

  Future<void> checkFamilyStatus() async {
    emit(const FamilyCreationChecking());
    final result = await _getUserFamilyUseCase();
    switch (result) {
      case ApiSuccess(data: final family):
        if (family != null) {
          emit(FamilyAlreadyExists(family));
        } else {
          await _checkForInvitations();
        }
      case ApiFailure(failure: final error):
        emit(FamilyCreationError(error.message));
    }
  }

  Future<void> _checkForInvitations() async {
    final invResult = await _checkPendingInvitationsUseCase();
    switch (invResult) {
      case ApiSuccess(data: final invitations):
        if (invitations.isNotEmpty) {
          emit(const HasPendingInvitations());
          return;
        }
      case ApiFailure():
        break;
    }
    emit(const FamilyCreationReady());
  }

  Future<void> createFamily(String name) async {
    emit(const FamilyCreationLoading());
    final result = await _createFamilyUseCase(name);
    switch (result) {
      case ApiSuccess(data: final family):
        emit(FamilyCreationSuccess(family));
      case ApiFailure(failure: final error):
        emit(FamilyCreationError(error.message));
    }
  }
}
