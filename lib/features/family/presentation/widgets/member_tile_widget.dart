import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/add_member_result.dart';

class MemberTileWidget extends StatelessWidget {
  const MemberTileWidget({super.key, required this.result});

  final AddMemberResult result;

  @override
  Widget build(BuildContext context) {
    final member = result.member;
    final invited = result.inviteStatus == InviteStatus.sent;
    final needsShare = result.inviteStatus == InviteStatus.userNotFound;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Text(
                  member.displayName.isNotEmpty
                      ? member.displayName[0].toUpperCase()
                      : '?',
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.displayName, style: AppTextStyles.bodyMedium),
                    Text(
                      member.email,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      member.role.displayName,
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    invited ? 'Invitation sent' : 'Pending — notify them',
                    style: AppTextStyles.caption.copyWith(
                      color:
                          invited ? AppColors.success : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (needsShare) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _shareInvite(member.displayName, member.email),
                icon: const Icon(Icons.share_outlined, size: 16),
                label: const Text('Send Invite Link'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  textStyle: AppTextStyles.caption,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _shareInvite(String displayName, String email) {
    Share.share(
      'Hi $displayName! You\'ve been invited to join a family budget on the Family Budgets app.\n\n'
      'Download the app and sign up with this email: $email\n'
      'Your membership will be activated automatically.',
    );
  }
}
