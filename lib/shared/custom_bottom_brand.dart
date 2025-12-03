import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/app_theme.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

class CustomBottomBrand extends StatelessWidget {
  const CustomBottomBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Stay organized with ', style: AppTextStyles.bottomBrand),
          SizedBox(width: 2.w),
          Assets.icons.logo.svg(),
          Text(
            'Workiom',
            style: AppTextStyles.title.copyWith(
              color: ColorName.woodsmoke,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
