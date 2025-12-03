import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';
import 'package:workiom_test_app/shared/custom_bottom_brand.dart';

import '../../../core/app_theme.dart';
import '../../../shared/stagger_column.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  static const routeName = 'thank-you';
  static const routePath = '/thank-you';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: StaggerColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),
              const Spacer(),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.title.copyWith(fontSize: 28.sp),
                  children: [
                    const TextSpan(text: 'Thank you for choosing\n'),
                    const TextSpan(text: 'Workiom '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Assets.icons.logo.svg(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const CustomBottomBrand(),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
