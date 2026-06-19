import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/family_member_role.dart';
import '../../domain/entities/add_member_result.dart';
import '../../domain/usecases/add_member_usecase.dart';
import 'add_members_state.dart';

class AddMembersCubit extends Cubit<AddMembersState> {
  final AddMemberUseCase _addMemberUseCase;

  AddMembersCubit(this._addMemberUseCase) : super(const AddMembersInitial());

  List<AddMemberResult> get _currentResults => switch (state) {
        AddMemberSubmitting(:final addedResults) => addedResults,
        AddMemberAdded(:final addedResults) => addedResults,
        AddMembersError(:final addedResults) => addedResults,
        _ => const [],
      };

  Future<void> addMember({
    required String familyId,
    required String displayName,
    required String email,
    required FamilyMemberRole role,
    double? monthlyBudget,
  }) async {
    final current = _currentResults;
    emit(AddMemberSubmitting(current));

    final result = await _addMemberUseCase(
      familyId: familyId,
      displayName: displayName,
      email: email,
      role: role,
      monthlyBudget: monthlyBudget,
    );

    result.when(
      success: (addMemberResult) =>
          emit(AddMemberAdded([...current, addMemberResult])),
      failure: (error) =>
          emit(AddMembersError(addedResults: current, message: error.message)),
    );
  }

  void complete() {
    if (_currentResults.isNotEmpty) emit(const AddMembersComplete());
  }
}
