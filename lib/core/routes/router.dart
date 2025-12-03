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

final appRouter = GoRouter(
  initialLocation: CreateAccountScreen.routePath,
  routes: [
    GoRoute(
      path: CreateAccountScreen.routePath,
      name: CreateAccountScreen.routeName,
      pageBuilder: (context, state) => const MaterialPage(
        child: CreateAccountScreen(),
      ),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(getIt<AuthRepository>()),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: PasswordScreen.routePath,
          name: PasswordScreen.routeName,
          pageBuilder: (context, state) => const MaterialPage(
            child: PasswordScreen(),
          ),
        ),
        GoRoute(
          path: CompanyScreen.routePath,
          name: CompanyScreen.routeName,
          pageBuilder: (context, state) => const MaterialPage(
            child: CompanyScreen(),
          ),
        ),
      ],
    ),

    GoRoute(
      path: ThankYouScreen.routePath,
      name: ThankYouScreen.routeName,
      pageBuilder: (context, state) => const MaterialPage(
        child: ThankYouScreen(),
      ),
    ),
  ],
);
