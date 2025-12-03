import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test_app/features/signup/cubit/sign_up_sate.dart';
import 'package:workiom_test_app/features/signup/screens/company_screen.dart';
import 'package:workiom_test_app/shared/custom_button.dart';

import '../cubit/sign_up_cubit.dart';

class PasswordSubmitButton extends StatelessWidget {
  const PasswordSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) =>
          prev.password != curr.password ||
          prev.complexity != curr.complexity ||
          prev.email != curr.email,
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();

        final bool canContinue =
            cubit.isPasswordValid && state.email.isNotEmpty;

        return CustomButton(
          text: 'Confirm password',
          isEnabled: canContinue,
          onTap: canContinue
              ? () {
                  context.pushNamed(CompanyScreen.routeName);
                }
              : null,
        );
      },
    );
  }
}
