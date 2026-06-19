import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/utils/widget_share/auth_email_field_widget.dart';
import '../../../../core/utils/widget_share/auth_password_field_widget.dart';
import '../../../../core/utils/widget_share/auth_submit_button_widget.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class LoginFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginFormWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthEmailFieldWidget(controller: emailController),
        const SizedBox(height: 16),
        AuthPasswordFieldWidget(
          controller: passwordController,
          obscureText: obscurePassword,
          onToggle: onTogglePassword,
          validator: Validators.password,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => TextButton(
              onPressed: state is AuthLoading ? null : onForgotPassword,
              child: const Text('Forgot Password?'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) => AuthSubmitButtonWidget(
            label: 'Sign In',
            isLoading: state is AuthLoading,
            onPressed: onLogin,
          ),
        ),
      ],
    );
  }
}
