import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:workiom_test_app/core/helper/debug_logger_helper.dart';
import 'package:workiom_test_app/features/signup/cubit/sign_up_sate.dart';
import '../../../features/auth/data/auth_repository_impl.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(const SignUpState()) {
    emailController = TextEditingController(text: state.email);
    passwordController = TextEditingController(text: state.password);
    tenantNameController = TextEditingController(text: state.tenantName);
    firstNameController = TextEditingController(text: state.firstName);
    lastNameController = TextEditingController(text: state.lastName);
  }

  final AuthRepository _authRepository;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController tenantNameController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    tenantNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }

  // UI updates

  void updateEmail(String value) {
    emit(state.copyWith(email: value.trim(), errorMessage: null));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value, errorMessage: null));
  }

  void updateTenantName(String value) {
    emit(state.copyWith(tenantName: value.trim(), errorMessage: null));
  }

  void updateFirstName(String value) {
    emit(state.copyWith(firstName: value.trim(), errorMessage: null));
  }

  void updateLastName(String value) {
    emit(state.copyWith(lastName: value.trim(), errorMessage: null));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  // Password validation

  bool get isPasswordValid {
    final complexity = state.complexity;
    final pwd = state.password;

    if (pwd.isEmpty) return false;

    if (complexity == null) {
      return pwd.length >= 7 && pwd.contains(RegExp(r'[A-Z]'));
    }

    if (pwd.length < complexity.requiredLength) {
      return false;
    }
    if (complexity.requireUppercase && !pwd.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (complexity.requireLowercase && !pwd.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    if (complexity.requireDigit && !pwd.contains(RegExp(r'\d'))) {
      return false;
    }
    if (complexity.requireNonAlphanumeric &&
        !pwd.contains(RegExp(r'[^a-zA-Z0-9]'))) {
      return false;
    }

    return true;
  }

  bool get isCompanyFormValid => state.isCompanyFormValid;

  // Load sign-up configuration

  Future<void> loadSignUpConfig() async {
    if (state.complexity != null && state.editionId != null) {
      return;
    }

    try {
      if (isClosed) return;
      emit(state.copyWith(isLoadingComplexity: true, errorMessage: null));

      final editionId = await _authRepository.getDefaultEditionId();
      if (isClosed) return;

      final complexity = await _authRepository.getPasswordComplexity();
      if (isClosed) return;

      emit(
        state.copyWith(
          editionId: editionId,
          complexity: complexity,
          isLoadingComplexity: false,
        ),
      );
    } catch (e, st) {
      DebugLoggerHelper.log('Error while loading sign up config: $e');
      DebugLoggerHelper.log('$st');

      if (isClosed) return;

      emit(
        state.copyWith(
          isLoadingComplexity: false,
          errorMessage: 'Failed to prepare sign up, please try again.',
        ),
      );
    }
  }

  // Submit registration

  Future<void> submit() async {
    if (state.email.isEmpty ||
        state.password.isEmpty ||
        state.tenantName.isEmpty ||
        state.firstName.isEmpty ||
        state.lastName.isEmpty) {
      if (isClosed) return;
      emit(state.copyWith(errorMessage: 'Please fill all fields'));
      return;
    }

    if (!isPasswordValid) {
      if (isClosed) return;
      emit(
        state.copyWith(
          errorMessage: 'Password does not meet the required complexity.',
        ),
      );
      return;
    }

    if (!state.isCompanyFormValid) {
      if (isClosed) return;
      emit(
        state.copyWith(
          errorMessage:
              'Please check workspace name and first/last name format.',
        ),
      );
      return;
    }

    if (state.editionId == null) {
      if (isClosed) return;
      emit(
        state.copyWith(
          errorMessage:
              'Could not determine default plan. Please restart the app.',
        ),
      );
      return;
    }

    if (isClosed) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final available = await _authRepository.isTenantAvailable(
        state.tenantName,
      );

      if (isClosed) return;

      if (!available) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'Workspace name is already taken',
          ),
        );
        return;
      }

      await _authRepository.registerTenantAndAuthenticate(
        email: state.email,
        password: state.password,
        firstName: state.firstName,
        lastName: state.lastName,
        tenantName: state.tenantName,
        editionId: state.editionId!,
      );

      if (isClosed) return;
      emit(state.copyWith(isSubmitting: false, success: true));
    } catch (e, st) {
      DebugLoggerHelper.log('Error while submitting sign up: $e');
      DebugLoggerHelper.log('$st');

      String message = 'Something went wrong, please try again.';

      if (e is DioException) {
        final data = e.response?.data;
        if (data is Map) {
          try {
            final outer = Map<String, dynamic>.from(data);
            final err = outer['error'];
            if (err is Map<String, dynamic>) {
              final ve = err['validationErrors'];
              if (ve is List && ve.isNotEmpty && ve.first is Map) {
                final firstVe = ve.first as Map;
                final veMsg = firstVe['message'] as String?;
                if (veMsg != null && veMsg.isNotEmpty) {
                  message = veMsg;
                }
              } else {
                message =
                    (err['details'] as String?) ??
                    (err['message'] as String?) ??
                    message;
              }
            }
          } catch (_) {}
        }
      }

      if (isClosed) return;
      emit(state.copyWith(isSubmitting: false, errorMessage: message));
    }
  }

  // Tutorial for CreateAccountScreen

  bool _createAccountTutorialShown = false;

  void showCreateAccountTutorial({
    required BuildContext context,
    required GlobalKey googleButtonKey,
    required GlobalKey emailButtonKey,
  }) {
    if (_createAccountTutorialShown) return;
    _createAccountTutorialShown = true;

    final targets = <TargetFocus>[
      TargetFocus(
        identify: 'google_button',
        keyTarget: googleButtonKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'You can quickly create your account using Google.',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'email_button',
        keyTarget: emailButtonKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Or continue with your work email.',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    TutorialCoachMark(
      targets: targets,
      paddingFocus: 8,
      colorShadow: Colors.black,
      opacityShadow: 0.7,
      hideSkip: false,
      textSkip: 'Skip',
      onFinish: () {},
      onSkip: () => true,
      onClickTarget: (target) {},
      onClickOverlay: (target) {},
    ).show(context: context);
  }
}
