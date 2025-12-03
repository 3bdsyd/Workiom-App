import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/features/signup/screens/password_screen.dart';
import 'package:workiom_test_app/features/signup/widgets/term_and_policy_widget.dart';
import 'package:workiom_test_app/shared/custom_appbar.dart';
import 'package:workiom_test_app/shared/custom_bottom_brand.dart';
import 'package:workiom_test_app/shared/custom_button.dart';
import 'package:workiom_test_app/shared/custom_google_button.dart';
import 'package:workiom_test_app/shared/custom_title.dart';

import '../../../core/app_theme.dart';
import '../../../shared/stagger_column.dart';

class CreateAccountBody extends StatelessWidget {
  const CreateAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggerColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppbar(title: 'Sign in'),
        CustomTitle(title: 'Create your free account'),
        Spacer(flex: 2),
        CustomGoogleButton(),
        SizedBox(height: 24.h),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Or',
            style: AppTextStyles.subtitle.copyWith(fontSize: 15.sp),
          ),
        ),
        SizedBox(height: 30.h),
        CustomButton(
          text: 'Continue with email',
          onTap: () {
            context.pushNamed(PasswordScreen.routeName);
          },
        ),
        SizedBox(height: 30.h),
        TermAndPolicyWidget(),
        Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.globe.svg(),
            SizedBox(width: 4.w),
            Text('English', style: AppTextStyles.small),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
        SizedBox(height: 16.h),
        const CustomBottomBrand(),
        SizedBox(height: 8.h),
      ],
    );
  }
}
