import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/add_member_result.dart';
import 'member_tile_widget.dart';

class AddedMembersListWidget extends StatelessWidget {
  const AddedMembersListWidget({super.key, required this.results});

  final List<AddMemberResult> results;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Added (${results.length})',
          style: AppTextStyles.labelMedium
              .copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        ...results.map(
          (r) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: MemberTileWidget(result: r),
          ),
        ),
      ],
    );
  }
}
