import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:workiom_test_app/core/helper/time_zone_helper.dart';
import 'package:workiom_test_app/core/network/network_info.dart';

import '../../../core/constants.dart';
import 'auth_api_service.dart';
import 'models/auth_result.dart';
import 'models/current_login_info.dart';
import 'models/password_complexity.dart';

class AuthRepository {
  AuthRepository(this._api, this._storage, this._networkInfo);

  final AuthApiService _api;
  final FlutterSecureStorage _storage;
  final NetworkInfo _networkInfo;

  String _expiryFromNowSeconds(int seconds) {
    final dt = DateTime.now().toUtc().add(Duration(seconds: seconds));
    return dt.toIso8601String();
  }

  Future<T> _requestWithRetry<T>(
    Future<T> Function() action, {
    int maxRetries = 3,
    Duration baseDelay = const Duration(milliseconds: 400),
    Duration noConnectionDelay = const Duration(seconds: 1),
  }) async {
    var attempt = 0;

    while (true) {
      // Wait until we have some connectivity
      while (!await _networkInfo.isConnected) {
        await Future.delayed(noConnectionDelay);
      }

      try {
        return await action();
      } on DioException catch (e) {
        // Retry only for transient network errors
        if (!_isTransientError(e)) {
          rethrow;
        }

        attempt++;
        if (attempt >= maxRetries) {
          rethrow;
        }

        final delay = baseDelay * attempt;
        await Future.delayed(delay);
      }
    }
  }

  bool _isTransientError(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout;
  }

  // ---- GetCurrentLoginInformations (raw) ----
  Future<Map<String, dynamic>> getCurrentLoginInformationRaw() async {
    final data = await _requestWithRetry(
      () => _api.getCurrentLoginInfos(),
    );

    if (data == null) {
      throw Exception('Empty response from GetCurrentLoginInformations');
    }

    return Map<String, dynamic>.from(data as Map);
  }

  Future<CurrentLoginInfo> getCurrentLoginInformation() async {
    final raw = await getCurrentLoginInformationRaw();
    final result = (raw['result'] ?? raw) as Map<String, dynamic>;
    return CurrentLoginInfo.fromJson(result);
  }

  // ---- Default edition id ----
  Future<int?> getDefaultEditionId() async {
    final raw = await _requestWithRetry(
      () => _api.getEditionsForSelect(),
    );
    final outer = Map<String, dynamic>.from(raw as Map);

    final result = (outer['result'] ?? outer) as Map<String, dynamic>;

    final editionsWithFeatures =
        (result['editionsWithFeatures'] as List<dynamic>?) ??
            const <dynamic>[];

    if (editionsWithFeatures.isEmpty) return null;

    final editions = editionsWithFeatures
        .map((e) => (e as Map?)?['edition'])
        .whereType<Map<String, dynamic>>()
        .toList();

    if (editions.isEmpty) return null;

    final registrable = editions
        .where((e) => (e['isRegistrable'] as bool?) ?? true)
        .toList();

    final selectedEdition =
        registrable.isNotEmpty ? registrable.first : editions.first;

    return selectedEdition['id'] as int?;
  }

  // ---- Password complexity ----
  Future<PasswordComplexitySetting> getPasswordComplexity() async {
    final raw = await _requestWithRetry(
      () => _api.getPasswordComplexitySetting(),
    );
    final map = Map<String, dynamic>.from(raw as Map);

    final result = (map['result'] ?? {}) as Map<String, dynamic>;
    final settingJson = (result['setting'] ?? {}) as Map<String, dynamic>;

    return PasswordComplexitySetting.fromJson(settingJson);
  }

  // ---- IsTenantAvailable ----
  Future<bool> isTenantAvailable(String tenantName) async {
    final raw = await _requestWithRetry(
      () => _api.isTenantAvailable({'tenancyName': tenantName}),
    );
    final outer = Map<String, dynamic>.from(raw as Map);

    final result = (outer['result'] ?? outer) as Map<String, dynamic>;
    final tenantId = result['tenantId'];
    return tenantId == null;
  }

  // ---- RegisterTenant + Authenticate + Save Session ----
  Future<CurrentLoginInfo> registerTenantAndAuthenticate({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String tenantName,
    required int editionId,
  }) async {
    final timeZone = await TimeZoneHelper.getSafeTimeZone();

    await _requestWithRetry(
      () => _api.registerTenant(timeZone, {
        'adminEmailAddress': email,
        'adminFirstName': firstName,
        'adminLastName': lastName,
        'adminPassword': password,
        'captchaResponse': null,
        'editionId': editionId,
        'name': tenantName,
        'tenancyName': tenantName,
      }),
    );

    final authRaw = await _requestWithRetry(
      () => _api.authenticate({
        'ianaTimeZone': timeZone,
        'password': password,
        'rememberClient': false,
        'returnUrl': null,
        'singleSignIn': false,
        'tenantName': tenantName,
        'userNameOrEmailAddress': email,
      }),
    );

    final authMap = Map<String, dynamic>.from(authRaw as Map);
    final result = (authMap['result'] ?? authMap) as Map<String, dynamic>;

    final authResult = AuthResult.fromJson(result);

    await _storage.write(key: kAuthTokenKey, value: authResult.accessToken);

    await _storage.write(
      key: kEncryptedAuthTokenKey,
      value: authResult.encryptedAccessToken,
    );

    await _storage.write(
      key: kAuthTokenExpiryKey,
      value: _expiryFromNowSeconds(authResult.expireInSeconds),
    );

    if (authResult.refreshToken != null) {
      await _storage.write(
        key: kRefreshTokenKey,
        value: authResult.refreshToken!,
      );
    }

    if (authResult.refreshTokenExpireInSeconds != null) {
      await _storage.write(
        key: kRefreshTokenExpiryKey,
        value: _expiryFromNowSeconds(
          authResult.refreshTokenExpireInSeconds!,
        ),
      );
    }

    final loginInfo = await getCurrentLoginInformation();

    final user = loginInfo.user;
    final tenant = loginInfo.tenant;

    if (user != null) {
      await _storage.write(
        key: kCurrentUserIdKey,
        value: user.id.toString(),
      );
      await _storage.write(
        key: kCurrentUserNameKey,
        value: user.userName,
      );
      await _storage.write(
        key: kCurrentUserEmailKey,
        value: user.emailAddress,
      );
    }

    if (tenant != null) {
      await _storage.write(
        key: kCurrentTenantIdKey,
        value: tenant.id.toString(),
      );
      await _storage.write(
        key: kCurrentTenantNameKey,
        value: tenant.tenancyName,
      );

      if (tenant.edition != null) {
        await _storage.write(
          key: kCurrentTenantEditionIdKey,
          value: tenant.edition!.id.toString(),
        );
        await _storage.write(
          key: kCurrentTenantEditionNameKey,
          value: tenant.edition!.displayName,
        );
      }
    }

    return loginInfo;
  }
}
