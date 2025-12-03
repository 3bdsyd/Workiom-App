import '../../../features/auth/data/models/password_complexity.dart';

class SignUpState {
  const SignUpState({
    this.email = '',
    this.password = '',
    this.tenantName = '',
    this.firstName = '',
    this.lastName = '',
    this.complexity,
    this.editionId,
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
  final int? editionId;
  final bool isLoadingComplexity;
  final bool isSubmitting;
  final String? errorMessage;
  final bool success;
  final bool obscurePassword;

  // ---------- Password helpers ----------

  int get requiredLength => complexity?.requiredLength ?? 7;

  bool get requireUppercaseFlag => complexity?.requireUppercase ?? true;
  bool get requireLowercaseFlag => complexity?.requireLowercase ?? false;
  bool get requireDigitFlag => complexity?.requireDigit ?? false;
  bool get requireSpecialFlag => complexity?.requireNonAlphanumeric ?? false;

  bool get hasMinLength => password.length >= requiredLength;
  bool get hasUppercase =>
      !requireUppercaseFlag || password.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase =>
      !requireLowercaseFlag || password.contains(RegExp(r'[a-z]'));
  bool get hasDigit => !requireDigitFlag || password.contains(RegExp(r'\d'));
  bool get hasSpecial =>
      !requireSpecialFlag || password.contains(RegExp(r'[^a-zA-Z0-9]'));

  // ---------- Company step validation ----------

  static final RegExp _tenantRegExp = RegExp(r'^[A-Za-z][A-Za-z0-9-]*$');
  static final RegExp _nameRegExp = RegExp(r'^[A-Za-z]+$');

  bool get isTenantNameValid =>
      tenantName.isNotEmpty && _tenantRegExp.hasMatch(tenantName);

  bool get isFirstNameValid =>
      firstName.isNotEmpty && _nameRegExp.hasMatch(firstName);

  bool get isLastNameValid =>
      lastName.isNotEmpty && _nameRegExp.hasMatch(lastName);

  bool get isCompanyFormValid =>
      isTenantNameValid && isFirstNameValid && isLastNameValid;

  // ---------- Password strength calculation ----------

  int get strengthLevels {
    final c = complexity;

    if (c == null) {
      return 2;
    }

    int count = 1; // length
    if (c.requireUppercase) {
      count++;
    }
    if (c.requireLowercase) {
      count++;
    }
    if (c.requireDigit) {
      count++;
    }
    if (c.requireNonAlphanumeric) {
      count++;
    }

    return count;
  }

  int get _passedRules {
    int count = 0;

    if (hasMinLength) {
      count++;
    }

    final c = complexity;
    if (c == null) {
      if (password.contains(RegExp(r'[A-Z]'))) {
        count++;
      }
      return count;
    }

    if (c.requireUppercase && password.contains(RegExp(r'[A-Z]'))) count++;
    if (c.requireLowercase && password.contains(RegExp(r'[a-z]'))) count++;
    if (c.requireDigit && password.contains(RegExp(r'\d'))) {
      count++;
    }
    if (c.requireNonAlphanumeric &&
        password.contains(RegExp(r'[^a-zA-Z0-9]'))) {
      count++;
    }

    return count;
  }

  double get strengthValue {
    final total = strengthLevels;
    if (total <= 0) return 0;
    return _passedRules / total;
  }

  // ---------- copyWith ----------

  SignUpState copyWith({
    String? email,
    String? password,
    String? tenantName,
    String? firstName,
    String? lastName,
    PasswordComplexitySetting? complexity,
    int? editionId,
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
      editionId: editionId ?? this.editionId,
      isLoadingComplexity: isLoadingComplexity ?? this.isLoadingComplexity,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      success: success ?? this.success,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
