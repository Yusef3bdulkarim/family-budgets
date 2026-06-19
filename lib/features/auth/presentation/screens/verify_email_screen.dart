import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/widget_share/auth_header_widget.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import '../widgets/verify_email_actions_widget.dart';
import '../widgets/verify_email_card_widget.dart';
import '../widgets/verify_email_waiting_chip_widget.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  Timer? _pollTimer;
  Timer? _countdownTimer;
  int _resendCooldown = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startPolling();
    _startCountdown();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      context.read<AuthCubit>().checkEmailVerification();
    });
  }

  void _startCountdown() {
    _resendCooldown = 30;
    _canResend = false;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _resendCooldown--;
        if (_resendCooldown <= 0) {
          _canResend = true;
          _countdownTimer?.cancel();
        }
      });
    });
  }

  void _onResend() {
    context.read<AuthCubit>().sendEmailVerification();
    _startCountdown();
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2 || parts[0].isEmpty) return email;
    final local = parts[0];
    final masked = '${local[0]}${'*' * (local.length - 1)}';
    return '$masked@${parts[1]}';
  }

  Future<void> _openEmailApp() async {
    final uri = Uri(scheme: 'mailto');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No email app found on this device')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<AuthCubit>().logout(),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: _onStateChange,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        const AuthHeaderWidget(
                          title: 'Verify your email',
                          subtitle:
                              'Confirm your email to start managing your family budget',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        VerifyEmailCardWidget(
                          maskedEmail: _maskEmail(widget.email),
                          onChangeEmail: () =>
                              context.read<AuthCubit>().logout(),
                        ),
                        const SizedBox(height: 24),
                        const VerifyEmailWaitingChipWidget(),
                      ],
                    ),
                  ),
                ),
                VerifyEmailActionsWidget(
                  canResend: _canResend,
                  resendCooldown: _resendCooldown,
                  onResend: _onResend,
                  onOpenEmailApp: _openEmailApp,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onStateChange(BuildContext context, AuthState state) {
    if (state is AuthEmailVerified) {
      context.go(AppRoutes.home);
    } else if (state is AuthLoggedOut) {
      context.go(AppRoutes.login);
    } else if (state is AuthEmailVerificationSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email resent'),
          backgroundColor: AppColors.success,
        ),
      );
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
