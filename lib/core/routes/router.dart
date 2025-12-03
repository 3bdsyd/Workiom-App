import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:workiom_test_app/core/di/service_locator.dart';
import 'package:workiom_test_app/features/auth/data/auth_repository_impl.dart';

import 'package:workiom_test_app/features/signup/cubit/sign_up_cubit.dart';
import 'package:workiom_test_app/features/signup/screens/company_screen.dart';
import 'package:workiom_test_app/features/signup/screens/create_account_screen.dart';
import 'package:workiom_test_app/features/signup/screens/password_screen.dart';
import 'package:workiom_test_app/features/signup/screens/thank_you_screen.dart';

import 'package:workiom_test_app/features/splash/cubit/splash_cubit.dart';
import 'package:workiom_test_app/features/splash/screens/splash_screen.dart';
import 'package:workiom_test_app/features/home/screens/home_screen.dart';
import 'package:workiom_test_app/features/tenant/screens/tenant_sign_in_screen.dart';
import 'package:workiom_test_app/features/tenant/screens/tenant_selection_screen.dart';

final appRouter = GoRouter(
  // Initial screen of the app
  initialLocation: SplashScreen.routePath,
  routes: [
    // ------------- Splash -------------
    GoRoute(
      path: SplashScreen.routePath,
      name: SplashScreen.routeName,
      pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider(
          create: (_) => SplashCubit(getIt<AuthRepository>())..checkSession(),
          child: const SplashScreen(),
        ),
      ),
    ),

    // ------------- Sign-up flow (password + company) wrapped with SignUpCubit -------------
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider<SignUpCubit>(
          create: (_) =>
              SignUpCubit(getIt<AuthRepository>())..loadSignUpConfig(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: CreateAccountScreen.routePath,
          name: CreateAccountScreen.routeName,
          pageBuilder: (context, state) =>
              const MaterialPage(child: CreateAccountScreen()),
        ),
        GoRoute(
          path: PasswordScreen.routePath,
          name: PasswordScreen.routeName,
          pageBuilder: (context, state) =>
              const MaterialPage(child: PasswordScreen()),
        ),
        GoRoute(
          path: CompanyScreen.routePath,
          name: CompanyScreen.routeName,
          pageBuilder: (context, state) =>
              const MaterialPage(child: CompanyScreen()),
        ),
      ],
    ),

    // ------------- Thank you -------------
    GoRoute(
      path: ThankYouScreen.routePath,
      name: ThankYouScreen.routeName,
      pageBuilder: (context, state) =>
          const MaterialPage(child: ThankYouScreen()),
    ),

    // ------------- Other App Screens -------------
    GoRoute(
      path: HomeScreen.routePath,
      name: HomeScreen.routeName,
      pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
      
    ),
    GoRoute(
      path: TenantSignInScreen.routePath,
      name: TenantSignInScreen.routeName,
      pageBuilder: (context, state) =>
          const MaterialPage(child: TenantSignInScreen()),
    ),
    GoRoute(
      path: TenantSelectionScreen.routePath,
      name: TenantSelectionScreen.routeName,
      pageBuilder: (context, state) =>
          const MaterialPage(child: TenantSelectionScreen()),
    ),
  ],
);
