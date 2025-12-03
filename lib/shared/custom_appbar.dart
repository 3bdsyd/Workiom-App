import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

import '../../core/app_theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.title});

  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: 30.w,
      leading: _BackButton(onTap: () => context.pop()),
      title: title == null
          ? null
          : Text(
              title!,
              style: AppTextStyles.title.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
                color: ColorName.cornflowerBlue,
              ),
            ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 32.w,
        height: 32.w,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Center(
            child: Assets.icons.backIcon.svg(
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                ColorName.cornflowerBlue,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
