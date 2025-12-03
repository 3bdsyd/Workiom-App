enum SplashStatus {
  initial,
  loading,
  navigateToSignUp,
  navigateToTenantSignIn,
  navigateToHome,
  navigateToTenantSelection,
  error,
}

class SplashState {
  const SplashState({this.status = SplashStatus.initial, this.errorMessage});

  final SplashStatus status;
  final String? errorMessage;

  SplashState copyWith({SplashStatus? status, String? errorMessage}) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
