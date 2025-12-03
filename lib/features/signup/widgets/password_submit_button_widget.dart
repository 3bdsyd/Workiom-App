import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test_app/features/signup/screens/company_screen.dart';
import 'package:workiom_test_app/shared/custom_button.dart';

import '../cubit/sign_up_cubit.dart';

class PasswordSubmitButton extends StatelessWidget {
  const PasswordSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) =>
          prev.password != curr.password || prev.complexity != curr.complexity,
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final isStrong = cubit.isPasswordValid;

        return CustomButton(
          text: 'Confirm password',
          isEnabled: !isStrong,
          onTap: !isStrong
              ? () {
                  context.pushNamed(CompanyScreen.routeName);
                  // TODO: نافيجيت ل CompanyScreen
                  // context.push(CompanyScreen.routePath);
                }
              : null,
        );
      },
    );
  }
}
