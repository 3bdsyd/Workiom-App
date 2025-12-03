import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/data/auth_repository_impl.dart';
import '../../../features/auth/data/models/password_complexity.dart';

class SignUpState {
  const SignUpState({
    this.email = '',
    this.password = '',
    this.tenantName = '',
    this.firstName = '',
    this.lastName = '',
    this.complexity,
    this.isLoadingComplexity = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.success = false,
    this.obscurePassword = true,
  });

  final String email;
  final String password;
  final String tenantName;
  final String firstName;
  final String lastName;
  final PasswordComplexitySetting? complexity;
  final bool isLoadingComplexity;
  final bool isSubmitting;
  final String? errorMessage;
  final bool success;
  final bool obscurePassword;

  int get requiredLength => complexity?.requiredLength ?? 7;
  bool get requireUppercaseFlag => complexity?.requireUppercase ?? true;
  bool get hasMinLength => password.length >= requiredLength;
  bool get hasUppercase =>
      !requireUppercaseFlag || password.contains(RegExp(r'[A-Z]'));
  double get strengthValue {
    final score = (hasMinLength ? 1 : 0) + (hasUppercase ? 1 : 0);
    return score / 2;
  }

  SignUpState copyWith({
    String? email,
    String? password,
    String? tenantName,
    String? firstName,
    String? lastName,
    PasswordComplexitySetting? complexity,
    bool? isLoadingComplexity,
    bool? isSubmitting,
    String? errorMessage,
    bool? success,
    bool? obscurePassword,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      tenantName: tenantName ?? this.tenantName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      complexity: complexity ?? this.complexity,
      isLoadingComplexity: isLoadingComplexity ?? this.isLoadingComplexity,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      success: success ?? this.success,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(const SignUpState()) {
    emailController = TextEditingController(text: state.email);
    passwordController = TextEditingController(text: state.password);
  }

  final AuthRepository _authRepository;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value.trim(), errorMessage: null));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value, errorMessage: null));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  // ---------------- validation ----------------

  bool get isPasswordValid {
    final complexity = state.complexity;
    final pwd = state.password;

    if (pwd.isEmpty) return false;

    if (complexity == null) {
      return pwd.length >= 7 && pwd.contains(RegExp(r'[A-Z]'));
    }

    if (pwd.length < complexity.requiredLength) return false;

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

  Future<void> submit() async {
    if (state.email.isEmpty ||
        state.password.isEmpty ||
        state.tenantName.isEmpty ||
        state.firstName.isEmpty ||
        state.lastName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please fill all fields'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final available = await _authRepository.isTenantAvailable(
        state.tenantName,
      );

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
      );

      emit(state.copyWith(isSubmitting: false, success: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Something went wrong, please try again.',
        ),
      );
    }
  }
}
