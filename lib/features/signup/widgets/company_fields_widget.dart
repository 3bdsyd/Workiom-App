import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/shared/custom_under_line_field.dart';

import '../../../core/app_theme.dart';
import '../cubit/sign_up_cubit.dart';

class CompanyFieldsWidget extends StatefulWidget {
  const CompanyFieldsWidget({super.key});

  @override
  State<CompanyFieldsWidget> createState() => _CompanyFieldsWidgetState();
}

class _CompanyFieldsWidgetState extends State<CompanyFieldsWidget> {
  late final TextEditingController _workspaceController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    final state = context.read<SignUpCubit>().state;
    _workspaceController = TextEditingController(text: state.tenantName);
    _firstNameController = TextEditingController(text: state.firstName);
    _lastNameController = TextEditingController(text: state.lastName);
  }

  @override
  void dispose() {
    _workspaceController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Workspace ----------
        Text('Your  company or team name', style: AppTextStyles.sectionTitle),
        SizedBox(height: 12.h),
        UnderlineField(
          controller: _workspaceController,
          hintText: 'Workspace name*',
          keyboardType: TextInputType.text,
          prefixIcon: Assets.icons.group,
          suffix: Text(
            '.workiom.com',
            style: AppTextStyles.hint.copyWith(color: AppColors.textSecondary),
          ),
          // onChanged: cubit.updateTenantName,
        ),

        SizedBox(height: 24.h),

        // ---------- First name ----------
        Text('Your first name', style: AppTextStyles.sectionTitle),
        SizedBox(height: 12.h),
        UnderlineField(
          controller: _firstNameController,
          hintText: 'Enter your First name',
          keyboardType: TextInputType.name,
          prefixIcon: Assets.icons.arrows,
          // onChanged: cubit.updateFirstName,
        ),

        SizedBox(height: 24.h),

        // ---------- Last name ----------
        Text('Your last name', style: AppTextStyles.sectionTitle),
        SizedBox(height: 12.h),
        UnderlineField(
          controller: _lastNameController,
          hintText: 'Enter your Last name',
          keyboardType: TextInputType.name,
          prefixIcon: Assets.icons.arrows,
          // onChanged: cubit.updateLastName,
        ),
      ],
    );
  }
}
