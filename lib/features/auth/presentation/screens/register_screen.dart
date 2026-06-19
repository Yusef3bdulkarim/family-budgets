import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/widget_share/auth_account_link_widget.dart';
import '../../../../core/utils/widget_share/auth_divider_widget.dart';
import '../../../../core/utils/widget_share/auth_header_widget.dart';
import '../../../../core/utils/widget_share/auth_social_buttons_widget.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import '../widgets/register_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: _onStateChange,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const AuthHeaderWidget(
                    title: 'Create Account',
                    subtitle: 'Start managing your family finances',
                  ),
                  const SizedBox(height: 32),
                  RegisterFormWidget(
                    formKey: _formKey,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    obscurePassword: _obscurePassword,
                    obscureConfirmPassword: _obscureConfirmPassword,
                    onTogglePassword: _togglePassword,
                    onToggleConfirmPassword: _toggleConfirmPassword,
                    onRegister: _onRegister,
                  ),
                  const SizedBox(height: 24),
                  const AuthDividerWidget(),
                  const SizedBox(height: 24),
                  AuthSocialButtonsWidget(
                    onGooglePressed: () =>
                        context.read<AuthCubit>().signInWithGoogle(),
                    onApplePressed: () =>
                        context.read<AuthCubit>().signInWithApple(),
                  ),
                  const SizedBox(height: 32),
                  AuthAccountLinkWidget(
                    message: 'Already have an account?',
                    actionLabel: 'Sign In',
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePassword() =>
      setState(() => _obscurePassword = !_obscurePassword);

  void _toggleConfirmPassword() =>
      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);

  void _onRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  void _onStateChange(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      context.go(AppRoutes.verifyEmail);
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
