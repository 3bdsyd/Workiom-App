import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test_app/features/signup/screens/thank_you_screen.dart';
import 'package:workiom_test_app/shared/custom_button.dart';

import '../cubit/sign_up_cubit.dart';

class CompanySubmitButton extends StatelessWidget {
  const CompanySubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) =>
          prev.tenantName != curr.tenantName ||
          prev.firstName != curr.firstName ||
          prev.lastName != curr.lastName ||
          prev.isSubmitting != curr.isSubmitting,
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();

        final isFormFilled =
            state.tenantName.trim().isNotEmpty &&
            state.firstName.trim().isNotEmpty &&
            state.lastName.trim().isNotEmpty;

        final isEnabled = isFormFilled && !state.isSubmitting;

        final text = state.isSubmitting ? 'Creating...' : 'Create Workspace';

        return CustomButton(
          text: text,
          isEnabled: !isEnabled,
          onTap: () {
            context.goNamed(ThankYouScreen.routeName);
          },
          // onTap: isEnabled ? cubit.submit : null,
        );
      },
    );
  }
}
