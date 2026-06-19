import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/family_member_role.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/add_members_cubit.dart';
import '../bloc/add_members_state.dart';

class MemberFormWidget extends StatefulWidget {
  const MemberFormWidget({
    super.key,
    required this.familyId,
    required this.isLoading,
  });

  final String familyId;
  final bool isLoading;

  @override
  State<MemberFormWidget> createState() => _MemberFormWidgetState();
}

class _MemberFormWidgetState extends State<MemberFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _budgetController = TextEditingController();
  FamilyMemberRole _selectedRole = FamilyMemberRole.familyMember;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final budget = double.tryParse(_budgetController.text.trim());
      context.read<AddMembersCubit>().addMember(
            familyId: widget.familyId,
            displayName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            role: _selectedRole,
            monthlyBudget: budget,
          );
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _budgetController.clear();
    setState(() => _selectedRole = FamilyMemberRole.familyMember);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMembersCubit, AddMembersState>(
      listener: (context, state) {
        if (state is AddMemberAdded) _resetForm();
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                hintText: 'e.g. Ahmed',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (v) => Validators.required(v, 'Display name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'e.g. ahmed@example.com',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<FamilyMemberRole>(
              initialValue: _selectedRole,
              decoration: const InputDecoration(
                labelText: 'Role',
                prefixIcon: Icon(Icons.shield_outlined),
              ),
              items: const [
                DropdownMenuItem(
                  value: FamilyMemberRole.coManager,
                  child: Text('Co-Manager'),
                ),
                DropdownMenuItem(
                  value: FamilyMemberRole.familyMember,
                  child: Text('Family Member'),
                ),
              ],
              onChanged: (role) {
                if (role != null) setState(() => _selectedRole = role);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _budgetController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Monthly Budget (optional)',
                hintText: 'e.g. 500',
                prefixIcon: Icon(Icons.wallet_outlined),
              ),
              onFieldSubmitted: (_) => widget.isLoading ? null : _onSubmit(),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: widget.isLoading ? null : _onSubmit,
              icon: widget.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
                  : const Icon(Icons.person_add_outlined),
              label: const Text('Add Member'),
            ),
          ],
        ),
      ),
    );
  }
}
