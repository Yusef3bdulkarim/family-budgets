import '../../domain/entities/add_member_result.dart';

sealed class AddMembersState {
  const AddMembersState();
}

class AddMembersInitial extends AddMembersState {
  const AddMembersInitial();
}

class AddMemberSubmitting extends AddMembersState {
  final List<AddMemberResult> addedResults;
  const AddMemberSubmitting(this.addedResults);
}

class AddMemberAdded extends AddMembersState {
  final List<AddMemberResult> addedResults;
  const AddMemberAdded(this.addedResults);
}

class AddMembersError extends AddMembersState {
  final List<AddMemberResult> addedResults;
  final String message;
  const AddMembersError({required this.addedResults, required this.message});
}

class AddMembersComplete extends AddMembersState {
  const AddMembersComplete();
}
