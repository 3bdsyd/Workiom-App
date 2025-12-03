import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/features/signup/widgets/company_submit_button_widget.dart';

import 'package:workiom_test_app/shared/custom_appbar.dart';
import 'package:workiom_test_app/shared/custom_bottom_brand.dart';
import 'package:workiom_test_app/shared/custom_title.dart';

import '../../../shared/stagger_column.dart';
import 'company_fields_widget.dart';

class CompanyBodyWidget extends StatelessWidget {
  const CompanyBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, bottomInset + 16.h),
      child: StaggerColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppbar(),
          CustomTitle(title: 'Enter your company name'),
          SizedBox(height: 32.h),

          CompanyFieldsWidget(),

          SizedBox(height: 32.h),

          CompanySubmitButton(),

          Expanded(child: SizedBox(height: 12.h)),
          CustomBottomBrand(),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
