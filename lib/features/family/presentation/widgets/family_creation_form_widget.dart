import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/family_creation_cubit.dart';

class FamilyCreationFormWidget extends StatefulWidget {
  const FamilyCreationFormWidget({super.key, required this.isLoading});

  final bool isLoading;

  @override
  State<FamilyCreationFormWidget> createState() =>
      _FamilyCreationFormWidgetState();
}

class _FamilyCreationFormWidgetState extends State<FamilyCreationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<FamilyCreationCubit>()
          .createFamily(_nameController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.family_restroom_rounded,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Create Your Family', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              Text(
                'Give your family a name to start managing your budget together',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Family Name',
                  hintText: 'e.g. The Al-Hassan Family',
                  prefixIcon: Icon(Icons.people_outline),
                ),
                validator: (value) => Validators.required(value, 'Family name'),
                onFieldSubmitted: (_) => widget.isLoading ? null : _onSubmit(),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: widget.isLoading ? null : _onSubmit,
                child: widget.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : const Text('Create Family'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
