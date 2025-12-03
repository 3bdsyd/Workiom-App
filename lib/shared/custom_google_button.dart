import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/app_theme.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

class CustomGoogleButton extends StatelessWidget {
  const CustomGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorName.wildSand,
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: () {
          // TODO: Google sign in
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.google.svg(),
            SizedBox(width: 8.w),
            Text(
              'Continue with Google ',
              style: AppTextStyles.title.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
