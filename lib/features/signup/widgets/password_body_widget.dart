import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/features/signup/widgets/password_submit_button_widget.dart';

import 'package:workiom_test_app/shared/custom_appbar.dart';
import 'package:workiom_test_app/shared/custom_bottom_brand.dart';
import 'package:workiom_test_app/shared/custom_title.dart';

import '../../../shared/stagger_column.dart';
import 'password_fields_widget.dart';

class PasswordBodyWidget extends StatelessWidget {
  const PasswordBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, bottomInset + 16.h),
      child: StaggerColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppbar(),

          CustomTitle(title: 'Enter a strong password'),
          SizedBox(height: 24.h),

          PasswordFieldsWidget(),
          SizedBox(height: 24.h),

          PasswordSubmitButton(),
          Expanded(child: SizedBox(height: 12.h)),

          CustomBottomBrand(),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
