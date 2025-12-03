import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';

class TermAndPolicyWidget extends StatelessWidget {
  const TermAndPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'By signing up, you agree ',
        style: AppTextStyles.small,
        children: [
          TextSpan(
            text: 'Terms Of Service',
            style: AppTextStyles.small.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          const TextSpan(text: ' And '),
          TextSpan(
            text: 'Privacy Policy',
            style: AppTextStyles.small.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
