import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';
import 'package:workiom_test_app/features/signup/cubit/sign_up_sate.dart';
import 'package:workiom_test_app/shared/custom_under_line_field.dart';

import '../../../core/app_theme.dart';
import '../cubit/sign_up_cubit.dart';

class CompanyFieldsWidget extends StatelessWidget {
  const CompanyFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Workspace ----------
        Text('Your  company or team name', style: AppTextStyles.sectionTitle),
        SizedBox(height: 12.h),

        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (prev, curr) => prev.tenantName != curr.tenantName,
          builder: (context, state) {
            final hasError =
                state.tenantName.isNotEmpty && !state.isTenantNameValid;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnderlineField(
                  controller: cubit.tenantNameController,
                  hintText: 'Workspace name*',
                  keyboardType: TextInputType.text,
                  prefixIcon: Assets.icons.group,
                  suffix: Text(
                    '.workiom.com',
                    style: AppTextStyles.hint.copyWith(
                      color: ColorName.emperor,
                    ),
                  ),
                  onChanged: cubit.updateTenantName,
                ),
                if (hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      'Workspace name must start with a letter and can '
                      'contain numbers and dashes only.',
                      style: AppTextStyles.hint.copyWith(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),

        SizedBox(height: 24.h),

        // ---------- First name ----------
        Text('Your first name', style: AppTextStyles.sectionTitle),
        SizedBox(height: 12.h),

        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (prev, curr) => prev.firstName != curr.firstName,
          builder: (context, state) {
            final hasError =
                state.firstName.isNotEmpty && !state.isFirstNameValid;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnderlineField(
                  controller: cubit.firstNameController,
                  hintText: 'Enter your First name',
                  keyboardType: TextInputType.name,
                  prefixIcon: Assets.icons.arrows,
                  onChanged: cubit.updateFirstName,
                ),
                if (hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      'First name must contain letters only.',
                      style: AppTextStyles.hint.copyWith(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),

        SizedBox(height: 24.h),

        // ---------- Last name ----------
        Text('Your last name', style: AppTextStyles.sectionTitle),
        SizedBox(height: 12.h),

        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (prev, curr) => prev.lastName != curr.lastName,
          builder: (context, state) {
            final hasError =
                state.lastName.isNotEmpty && !state.isLastNameValid;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnderlineField(
                  controller: cubit.lastNameController,
                  hintText: 'Enter your Last name',
                  keyboardType: TextInputType.name,
                  prefixIcon: Assets.icons.arrows,
                  onChanged: cubit.updateLastName,
                ),
                if (hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      'Last name must contain letters only.',
                      style: AppTextStyles.hint.copyWith(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
