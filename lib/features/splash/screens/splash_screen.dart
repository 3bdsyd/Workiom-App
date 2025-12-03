import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_test_app/core/gen/assets.gen.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

import 'package:workiom_test_app/features/splash/cubit/splash_cubit.dart';
import 'package:workiom_test_app/features/signup/screens/create_account_screen.dart';
import 'package:workiom_test_app/features/splash/cubit/splash_state.dart';
import 'package:workiom_test_app/features/home/screens/home_screen.dart';
import 'package:workiom_test_app/features/tenant/screens/tenant_sign_in_screen.dart';
import 'package:workiom_test_app/features/tenant/screens/tenant_selection_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routePath = '/splash';
  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case SplashStatus.navigateToSignUp:
            context.goNamed(CreateAccountScreen.routeName);
            break;
          case SplashStatus.navigateToHome:
            context.goNamed(HomeScreen.routeName);
            break;
          case SplashStatus.navigateToTenantSignIn:
            context.goNamed(TenantSignInScreen.routeName);
            break;
          case SplashStatus.navigateToTenantSelection:
            context.goNamed(TenantSelectionScreen.routeName);
            break;
          case SplashStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Unknown error')),
            );
            break;
          default:
            break;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.images.splash.image(height: 80),
                SizedBox(height: 24),
                CircularProgressIndicator(
                  color: ColorName.cornflowerBlue,
                  backgroundColor: ColorName.nobel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
