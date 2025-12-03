import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:workiom_test_app/features/signup/cubit/sign_up_cubit.dart';
import 'package:workiom_test_app/features/signup/widgets/create_account_body_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  static const routeName = 'create-account';
  static const routePath = '/';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey _googleButtonKey = GlobalKey();
  final GlobalKey _emailButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<SignUpCubit>();
      cubit.showCreateAccountTutorial(
        context: context,
        googleButtonKey: _googleButtonKey,
        emailButtonKey: _emailButtonKey,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CreateAccountBody(
            googleButtonKey: _googleButtonKey,
            emailButtonKey: _emailButtonKey,
          ),
        ),
      ),
    );
  }
}
