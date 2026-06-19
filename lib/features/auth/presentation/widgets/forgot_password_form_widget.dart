import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widget_share/auth_email_field_widget.dart';
import '../../../../core/utils/widget_share/auth_submit_button_widget.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class ForgotPasswordFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSubmit;

  const ForgotPasswordFormWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthEmailFieldWidget(
          controller: emailController,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 32),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) => AuthSubmitButtonWidget(
            label: 'Send Reset Link',
            isLoading: state is AuthLoading,
            onPressed: onSubmit,
          ),
        ),
      ],
    );
  }
}
