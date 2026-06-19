import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/invitation_entity.dart';
import 'invitation_card_widget.dart';

class PendingInvitationsListWidget extends StatelessWidget {
  final List<InvitationEntity> invitations;
  final String? respondingId;
  final String? errorMessage;

  const PendingInvitationsListWidget({
    super.key,
    required this.invitations,
    this.respondingId,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            _buildIcon(),
            const SizedBox(height: 32),
            Text('Family Invitations', style: AppTextStyles.h1),
            const SizedBox(height: 8),
            Text(
              'You have been invited to join a family. '
              'Accept to start managing budgets together.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 16),
              _buildErrorBanner(),
            ],
            const SizedBox(height: 32),
            ...invitations.map(
              (invitation) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InvitationCardWidget(
                  invitation: invitation,
                  isResponding: respondingId == invitation.id,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go(AppRoutes.familyCreation),
              child: const Text('Skip — Create my own family'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.mail_rounded,
          size: 40,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        errorMessage!,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
      ),
    );
  }
}
