import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workiom_test_app/features/signup/cubit/sign_up_sate.dart';
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

        final bool canSubmit = state.isCompanyFormValid && !state.isSubmitting;

        final String text = state.isSubmitting
            ? 'Creating...'
            : 'Create Workspace';

        return CustomButton(
          text: text,
          isEnabled: canSubmit,
          onTap: canSubmit ? cubit.submit : null,
        );
      },
    );
  }
}
