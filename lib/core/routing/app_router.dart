import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/dependency_injection.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/verify_email_screen.dart';
import '../../features/family/presentation/bloc/add_members_cubit.dart';
import '../../features/family/presentation/bloc/family_creation_cubit.dart';
import '../../features/family/presentation/screens/add_members_screen.dart';
import '../../features/family/presentation/screens/family_creation_screen.dart';
import '../../features/invitation/presentation/bloc/pending_invitations_cubit.dart';
import '../../features/invitation/presentation/screens/pending_invitations_screen.dart';

abstract final class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const verifyEmail = '/verify-email';
  static const familyCreation = '/family-creation';
  static const addMembers = '/add-members';
  static const pendingInvitations = '/pending-invitations';
  static const home = '/home';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.familyCreation,
  redirect: (context, state) {
    final user = getIt<FirebaseAuth>().currentUser;
    final isLoggedIn = user != null;
    final isEmailVerified = user?.emailVerified ?? false;
    final isAuthRoute = state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.register ||
        state.matchedLocation == AppRoutes.forgotPassword;
    final isVerifyRoute = state.matchedLocation == AppRoutes.verifyEmail;

    if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
    if (isLoggedIn && !isEmailVerified && !isVerifyRoute) {
      return AppRoutes.verifyEmail;
    }
    if (isLoggedIn && isEmailVerified && (isAuthRoute || isVerifyRoute)) {
      return AppRoutes.familyCreation;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: const RegisterScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: const ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.verifyEmail,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: VerifyEmailScreen(
          email: getIt<FirebaseAuth>().currentUser?.email ?? '',
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.familyCreation,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<FamilyCreationCubit>(),
        child: const FamilyCreationScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.addMembers,
      redirect: (context, state) {
        if (state.extra is! String) return AppRoutes.familyCreation;
        return null;
      },
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<AddMembersCubit>(),
        child: AddMembersScreen(familyId: state.extra! as String),
      ),
    ),
    GoRoute(
      path: AppRoutes.pendingInvitations,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<PendingInvitationsCubit>(),
        child: const PendingInvitationsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Home — Coming Soon')),
      ),
    ),
  ],
);
