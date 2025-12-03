import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workiom_test_app/core/helper/debug_logger_helper.dart';
import 'package:workiom_test_app/features/auth/data/auth_repository_impl.dart';
import 'package:workiom_test_app/features/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authRepository) : super(const SplashState());

  final AuthRepository _authRepository;

  Future<void> checkSession() async {
    if (isClosed) return;
    emit(state.copyWith(status: SplashStatus.loading, errorMessage: null));

    try {
      final info = await _authRepository.getCurrentLoginInformation();
      if (isClosed) return;

      final user = info.user;
      final tenant = info.tenant;

      if (user == null && tenant == null) {
        DebugLoggerHelper.log(
          'Splash: no user & no tenant -> go to Sign Up flow.',
        );
        if (isClosed) return;
        emit(state.copyWith(status: SplashStatus.navigateToSignUp));
      } else if (user == null && tenant != null) {
        DebugLoggerHelper.log(
          'Splash: tenant exists but user is null -> go to Tenant Sign-In.',
        );
        if (isClosed) return;
        emit(state.copyWith(status: SplashStatus.navigateToTenantSignIn));
      } else if (user != null && tenant != null) {
        DebugLoggerHelper.log(
          'Splash: user & tenant not null -> go to Home.',
        );
        if (isClosed) return;
        emit(state.copyWith(status: SplashStatus.navigateToHome));
      } else {
        DebugLoggerHelper.log(
          'Splash: user exists but no tenant -> go to Tenant selection.',
        );
        if (isClosed) return;
        emit(state.copyWith(status: SplashStatus.navigateToTenantSelection));
      }
    } catch (e, st) {
      DebugLoggerHelper.log('Splash: error while checking login info: $e');
      DebugLoggerHelper.log('$st');

      if (isClosed) return;
      emit(
        state.copyWith(
          status: SplashStatus.error,
          errorMessage: 'Failed to check login information.',
        ),
      );
    }
  }
}
