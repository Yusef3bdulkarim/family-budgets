import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/family_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/family_entity.dart';
import '../bloc/family_settings_cubit.dart';
import '../bloc/family_settings_state.dart';
import '../widgets/family_settings_auto_approval_field_widget.dart';
import '../widgets/family_settings_auto_approval_row_widget.dart';
import '../widgets/family_settings_budget_day_row_widget.dart';
import '../widgets/family_settings_currency_dropdown_widget.dart';
import '../widgets/family_settings_section_header_widget.dart';

class FamilySettingsScreen extends StatefulWidget {
  const FamilySettingsScreen({super.key});

  @override
  State<FamilySettingsScreen> createState() => _FamilySettingsScreenState();
}

class _FamilySettingsScreenState extends State<FamilySettingsScreen> {
  int _budgetStartDay = FamilyConstants.minBudgetStartDay;
  String _currency = FamilyConstants.defaultCurrency;
  bool _autoApprovalEnabled = false;
  final _autoApprovalController = TextEditingController();
  FamilyEntity? _family;

  @override
  void initState() {
    super.initState();
    context.read<FamilySettingsCubit>().loadSettings();
  }

  @override
  void dispose() {
    _autoApprovalController.dispose();
    super.dispose();
  }

  void _initFromFamily(FamilyEntity family) {
    _family = family;
    _budgetStartDay = family.budgetStartDay;
    _currency = family.currency;
    _autoApprovalEnabled = family.autoApprovalLimit != null;
    if (family.autoApprovalLimit != null) {
      final v = family.autoApprovalLimit!;
      _autoApprovalController.text =
          v == v.truncateToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(2);
    } else {
      _autoApprovalController.text = '';
    }
  }

  void _save() {
    if (_family == null) return;

    double? limit;
    if (_autoApprovalEnabled) {
      final parsed = double.tryParse(_autoApprovalController.text.trim());
      if (parsed == null ||
          parsed <= 0 ||
          parsed > FamilyConstants.maxAutoApprovalLimit) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid auto-approval amount')),
        );
        return;
      }
      limit = parsed;
    }

    context.read<FamilySettingsCubit>().saveSettings(
          familyId: _family!.id,
          budgetStartDay: _budgetStartDay,
          currency: _currency,
          autoApprovalLimit: limit,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Settings'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: BlocConsumer<FamilySettingsCubit, FamilySettingsState>(
        listener: (context, state) {
          if (state is FamilySettingsLoaded && _family == null) {
            setState(() => _initFromFamily(state.family));
          }
          if (state is FamilySettingsSaved) {
            setState(() => _initFromFamily(state.family));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings saved')),
            );
          }
          if (state is FamilySettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is FamilySettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FamilySettingsError && _family == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        context.read<FamilySettingsCubit>().loadSettings(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (_family == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final isSaving = state is FamilySettingsSaving;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const FamilySettingsSectionHeaderWidget(title: 'Budget Period'),
              const SizedBox(height: 12),
              FamilySettingsBudgetDayRowWidget(
                value: _budgetStartDay,
                onChanged: (v) => setState(() => _budgetStartDay = v),
              ),
              const SizedBox(height: 24),
              const FamilySettingsSectionHeaderWidget(title: 'Currency'),
              const SizedBox(height: 12),
              FamilySettingsCurrencyDropdownWidget(
                value: _currency,
                onChanged: (v) => setState(() => _currency = v),
              ),
              const SizedBox(height: 24),
              const FamilySettingsSectionHeaderWidget(title: 'Auto-Approval'),
              const SizedBox(height: 4),
              Text(
                'Requests below this amount are approved automatically.',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              FamilySettingsAutoApprovalRowWidget(
                enabled: _autoApprovalEnabled,
                onChanged: (v) => setState(() {
                  _autoApprovalEnabled = v;
                  if (!v) _autoApprovalController.clear();
                }),
              ),
              if (_autoApprovalEnabled) ...[
                const SizedBox(height: 12),
                FamilySettingsAutoApprovalFieldWidget(
                  controller: _autoApprovalController,
                  currency: _currency,
                ),
              ],
              const SizedBox(height: 40),
              FilledButton(
                onPressed: isSaving ? null : _save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'Save Settings',
                        style: AppTextStyles.bodyLarge
                            .copyWith(color: AppColors.white),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
