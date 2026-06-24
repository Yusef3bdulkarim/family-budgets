import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/family_creation_cubit.dart';
import '../bloc/family_creation_state.dart';
import '../widgets/family_creation_form_widget.dart';

class FamilyCreationScreen extends StatefulWidget {
  const FamilyCreationScreen({super.key});

  @override
  State<FamilyCreationScreen> createState() => _FamilyCreationScreenState();
}

class _FamilyCreationScreenState extends State<FamilyCreationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FamilyCreationCubit>().checkFamilyStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FamilyCreationCubit, FamilyCreationState>(
        listener: (context, state) {
          if (state is FamilyAlreadyExists) {
            context.go(AppRoutes.home);
          } else if (state is FamilyCreationSuccess) {
            context.go(AppRoutes.addMembers, extra: state.family.id);
          } else if (state is HasPendingInvitations) {
            context.go(AppRoutes.pendingInvitations);
          } else if (state is FamilyAutoJoined) {
            context.go(AppRoutes.home);
          } else if (state is FamilyCreationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) => switch (state) {
          FamilyCreationInitial() ||
          FamilyCreationChecking() ||
          FamilyAlreadyExists() ||
          FamilyCreationSuccess() ||
          HasPendingInvitations() ||
          FamilyAutoJoined() => const Center(
            child: CircularProgressIndicator(),
          ),
          FamilyCreationReady() ||
          FamilyCreationLoading() ||
          FamilyCreationError() => FamilyCreationFormWidget(
            isLoading: state is FamilyCreationLoading,
          ),
        },
      ),
    );
  }
}
