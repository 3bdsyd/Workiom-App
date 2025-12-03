import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/app_theme.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(title, style: AppTextStyles.title),
        SizedBox(height: 8.h),
        Text(
          "Let's start an amazing journey! 👋🏻",
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }
}
