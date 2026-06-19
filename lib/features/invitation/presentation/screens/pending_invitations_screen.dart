import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../bloc/pending_invitations_cubit.dart';
import '../bloc/pending_invitations_state.dart';
import '../widgets/pending_invitations_list_widget.dart';

class PendingInvitationsScreen extends StatefulWidget {
  const PendingInvitationsScreen({super.key});

  @override
  State<PendingInvitationsScreen> createState() =>
      _PendingInvitationsScreenState();
}

class _PendingInvitationsScreenState extends State<PendingInvitationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PendingInvitationsCubit>().loadInvitations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PendingInvitationsCubit, PendingInvitationsState>(
        listener: _handleStateChange,
        builder: (context, state) => switch (state) {
          PendingInvitationsInitial() ||
          PendingInvitationsLoading() =>
            const Center(child: CircularProgressIndicator()),
          PendingInvitationsLoaded(:final invitations) =>
            PendingInvitationsListWidget(invitations: invitations),
          InvitationResponding(:final invitations, :final respondingId) =>
            PendingInvitationsListWidget(
              invitations: invitations,
              respondingId: respondingId,
            ),
          InvitationRejected(:final remainingInvitations) =>
            PendingInvitationsListWidget(invitations: remainingInvitations),
          PendingInvitationsError(:final message, :final invitations) =>
            invitations.isNotEmpty
                ? PendingInvitationsListWidget(
                    invitations: invitations,
                    errorMessage: message,
                  )
                : Center(child: Text(message)),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }

  void _handleStateChange(BuildContext context, PendingInvitationsState state) {
    if (state is InvitationAccepted) {
      context.go(AppRoutes.home);
    } else if (state is PendingInvitationsEmpty) {
      context.go(AppRoutes.familyCreation);
    } else if (state is PendingInvitationsError && state.invitations.isEmpty) {
      context.go(AppRoutes.familyCreation);
    }
  }
}
