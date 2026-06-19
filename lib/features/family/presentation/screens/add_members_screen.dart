import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/add_member_result.dart';
import '../bloc/add_members_cubit.dart';
import '../bloc/add_members_state.dart';
import '../widgets/added_members_list_widget.dart';
import '../widgets/done_bar_widget.dart';
import '../widgets/member_form_widget.dart';

class AddMembersScreen extends StatelessWidget {
  final String familyId;

  const AddMembersScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddMembersCubit, AddMembersState>(
        listener: (context, state) {
          if (state is AddMembersComplete) {
            context.go(AppRoutes.home);
          } else if (state is AddMemberAdded) {
            final lastResult = state.addedResults.last;
            final message = lastResult.inviteStatus == InviteStatus.sent
                ? '${lastResult.member.displayName} added — invitation sent!'
                : '${lastResult.member.displayName} added';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is AddMembersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final addedResults = switch (state) {
            AddMemberSubmitting(:final addedResults) => addedResults,
            AddMemberAdded(:final addedResults) => addedResults,
            AddMembersError(:final addedResults) => addedResults,
            _ => const <AddMemberResult>[],
          };
          final isSubmitting = state is AddMemberSubmitting;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        Text('Add Family Members', style: AppTextStyles.h1),
                        const SizedBox(height: 8),
                        Text(
                          'Add at least one member to continue',
                          style: AppTextStyles.bodyMedium
                              .copyWith(color: AppColors.textSecondary),
                        ),
                        if (addedResults.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          AddedMembersListWidget(results: addedResults),
                        ],
                        const SizedBox(height: 32),
                        MemberFormWidget(
                          familyId: familyId,
                          isLoading: isSubmitting,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                DoneBarWidget(
                  enabled: addedResults.isNotEmpty && !isSubmitting,
                  onDone: () => context.read<AddMembersCubit>().complete(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
