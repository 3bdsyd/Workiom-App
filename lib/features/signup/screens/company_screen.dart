import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test_app/features/signup/cubit/sign_up_sate.dart';
import 'package:workiom_test_app/features/signup/widgets/company_body_widget.dart';

import '../cubit/sign_up_cubit.dart';
import 'thank_you_screen.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  static const routeName = 'company';
  static const routePath = '/company';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (prev, curr) =>
              prev.errorMessage != curr.errorMessage ||
              prev.success != curr.success,
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }

            if (state.success) {
              context.goNamed(ThankYouScreen.routeName);
            }
          },
          child: const CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: CompanyBodyWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
