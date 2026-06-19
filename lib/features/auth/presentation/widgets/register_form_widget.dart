import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/utils/widget_share/auth_email_field_widget.dart';
import '../../../../core/utils/widget_share/auth_password_field_widget.dart';
import '../../../../core/utils/widget_share/auth_submit_button_widget.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import 'register_name_row_widget.dart';

class RegisterFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onRegister;

  const RegisterFormWidget({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RegisterNameRowWidget(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
        ),
        const SizedBox(height: 16),
        AuthEmailFieldWidget(controller: emailController),
        const SizedBox(height: 16),
        AuthPasswordFieldWidget(
          controller: passwordController,
          obscureText: obscurePassword,
          onToggle: onTogglePassword,
          validator: Validators.password,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AuthPasswordFieldWidget(
          controller: confirmPasswordController,
          obscureText: obscureConfirmPassword,
          onToggle: onToggleConfirmPassword,
          labelText: 'Confirm Password',
          hintText: 'Re-enter your password',
          validator: (value) =>
              Validators.confirmPassword(value, passwordController.text),
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 32),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) => AuthSubmitButtonWidget(
            label: 'Create Account',
            isLoading: state is AuthLoading,
            onPressed: onRegister,
          ),
        ),
      ],
    );
  }
}
