import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/invitation_entity.dart';
import '../bloc/pending_invitations_cubit.dart';
import 'invitation_info_chip_widget.dart';

class InvitationCardWidget extends StatelessWidget {
  final InvitationEntity invitation;
  final bool isResponding;

  const InvitationCardWidget({
    super.key,
    required this.invitation,
    this.isResponding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildInfoRow(),
          const SizedBox(height: 20),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Text(
            invitation.familyName.isNotEmpty
                ? invitation.familyName[0].toUpperCase()
                : '?',
            style: AppTextStyles.h2.copyWith(color: AppColors.primary),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(invitation.familyName, style: AppTextStyles.h3),
              const SizedBox(height: 2),
              Text(
                'Invited by ${invitation.senderName}',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          InvitationInfoChipWidget(
            icon: Icons.person_outline,
            label: invitation.displayName,
          ),
          const SizedBox(width: 16),
          InvitationInfoChipWidget(
            icon: Icons.shield_outlined,
            label: invitation.role.displayName,
          ),
          if (invitation.monthlyBudget != null) ...[
            const SizedBox(width: 16),
            InvitationInfoChipWidget(
              icon: Icons.wallet_outlined,
              label: invitation.monthlyBudget!.toStringAsFixed(0),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isResponding
                ? null
                : () => context
                    .read<PendingInvitationsCubit>()
                    .reject(invitation),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
            ),
            child: const Text('Decline'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: isResponding
                ? null
                : () => context
                    .read<PendingInvitationsCubit>()
                    .accept(invitation),
            child: isResponding
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : const Text('Accept & Join'),
          ),
        ),
      ],
    );
  }
}
