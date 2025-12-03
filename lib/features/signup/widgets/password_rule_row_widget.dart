import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/app_theme.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';

class PasswordRuleRow extends StatelessWidget {
  const PasswordRuleRow({super.key, required this.ok, required this.text});

  final bool ok;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          ok
              ? Assets.icons.right.svg(height: 16, width: 16)
              : Assets.icons.error.svg(height: 16, width: 16),
          SizedBox(width: 4.w),
          Expanded(child: Text(text, style: AppTextStyles.small)),
        ],
      ),
    );
  }
}
