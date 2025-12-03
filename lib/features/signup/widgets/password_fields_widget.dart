import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';
import 'package:workiom_test_app/features/signup/cubit/sign_up_sate.dart';
import 'package:workiom_test_app/shared/custom_under_line_field.dart';

import '../../../core/app_theme.dart';
import '../cubit/sign_up_cubit.dart';
import 'password_rule_row_widget.dart';
import 'password_strength_bar_widget.dart';

class PasswordFieldsWidget extends StatelessWidget {
  const PasswordFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    final emailController = cubit.emailController;
    final passwordController = cubit.passwordController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your work email', style: AppTextStyles.sectionTitle),
        SizedBox(height: 8.h),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: emailController,
          builder: (context, value, _) {
            final hasText = value.text.isNotEmpty;
            return UnderlineField(
              controller: emailController,
              hintText: 'reem.alfattal@tech_deal.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Assets.icons.email,
              autofillHints: const [AutofillHints.email],
              suffix: hasText
                  ? GestureDetector(
                      onTap: () {
                        emailController.clear();
                        cubit.updateEmail('');
                      },
                      child: Assets.icons.clear.svg(),
                    )
                  : null,
              onChanged: cubit.updateEmail,
            );
          },
        ),

        SizedBox(height: 24.h),

        Text('Your password', style: AppTextStyles.sectionTitle),
        SizedBox(height: 8.h),

        BlocSelector<SignUpCubit, SignUpState, bool>(
          selector: (state) => state.obscurePassword,
          builder: (context, obscure) {
            return UnderlineField(
              controller: passwordController,
              hintText: '********',
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscure,
              prefixIcon: Assets.icons.lock,
              autofillHints: const [AutofillHints.password],
              suffix: SizedBox(
                width: 30.w,
                height: 30.w,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                  onPressed: cubit.togglePasswordVisibility,
                  icon: Assets.icons.eye.svg(
                    colorFilter: ColorFilter.mode(
                      obscure ? ColorName.woodsmoke : ColorName.cornflowerBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              onChanged: cubit.updatePassword,
            );
          },
        ),

        SizedBox(height: 12.h),

        const _PasswordStrengthAndRules(),
      ],
    );
  }
}

class _PasswordStrengthAndRules extends StatelessWidget {
  const _PasswordStrengthAndRules();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) =>
          prev.password != curr.password ||
          prev.complexity != curr.complexity ||
          prev.isLoadingComplexity != curr.isLoadingComplexity,
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();

        if (state.isLoadingComplexity) {
          return Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: const LinearProgressIndicator(),
          );
        }

        final bool hasMinLength = state.hasMinLength;
        final bool hasUppercase = state.hasUppercase;
        final bool hasLowercase = state.hasLowercase;
        final bool hasDigit = state.hasDigit;
        final bool hasSpecial = state.hasSpecial;

        final double strengthValue = state.strengthValue;
        final int requiredLength = state.requiredLength;
        final bool isStrong = cubit.isPasswordValid;

        final Color strengthColor = isStrong
            ? ColorName.pastelGreen
            : ColorName.casablanca;

        final complexity = state.complexity;

        final bool showUppercase = complexity == null
            ? true
            : complexity.requireUppercase;
        final bool showLowercase = complexity?.requireLowercase ?? false;
        final bool showDigit = complexity?.requireDigit ?? false;
        final bool showSpecial = complexity?.requireNonAlphanumeric ?? false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordStrengthBar(value: strengthValue, color: strengthColor),
            SizedBox(height: 12.h),
            Row(
              children: [
                isStrong
                    ? Assets.icons.right.svg(height: 16, width: 16)
                    : Assets.icons.warning.svg(height: 16, width: 16),
                SizedBox(width: 4.w),
                Text(
                  isStrong ? 'Password is strong' : 'Not enough strong',
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 15.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            PasswordRuleRow(
              ok: hasMinLength,
              text: 'Passwords must have at least $requiredLength characters',
            ),
            if (showUppercase)
              PasswordRuleRow(
                ok: hasUppercase,
                text: "Passwords must have at least one uppercase ('A'-'Z').",
              ),
            if (showLowercase)
              PasswordRuleRow(
                ok: hasLowercase,
                text: "Passwords must have at least one lowercase ('a'-'z').",
              ),
            if (showDigit)
              PasswordRuleRow(
                ok: hasDigit,
                text: "Passwords must have at least one digit ('0'-'9').",
              ),
            if (showSpecial)
              PasswordRuleRow(
                ok: hasSpecial,
                text: 'Passwords must have at least one special character.',
              ),
          ],
        );
      },
    );
  }
}
