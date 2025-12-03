import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants.dart';
import 'auth_api_service.dart';
import 'models/password_complexity.dart';

class AuthRepository {
  AuthRepository(this._api, this._storage);

  final AuthApiService _api;
  final FlutterSecureStorage _storage;

  Future<Map<String, dynamic>> getCurrentLoginInformation() async {
    final data = await _api.getCurrentLoginInfos();
    return data;
  }

  Future<PasswordComplexitySetting> getPasswordComplexity() async {
    final data = await _api.getPasswordComplexitySetting();
    final settingJson = (data['result'] ?? data) as Map<String, dynamic>;
    return PasswordComplexitySetting.fromJson(settingJson);
  }

  Future<int?> getDefaultEditionId() async {
    final data = await _api.getEditionsForSelect();
    final result = (data['result'] ?? data) as Map<String, dynamic>;
    final editions = (result['editionsWithFeatures'] as List<dynamic>?)
            ?.whereType<Map<String, dynamic>>()
            .toList() ??
        <Map<String, dynamic>>[];

    if (editions.isEmpty) return null;

    final registrable = editions
        .where((e) => (e['isRegistrable'] as bool?) ?? true)
        .toList();

    final selected = registrable.isNotEmpty ? registrable.first : editions.first;
    return selected['id'] as int?;
  }

  Future<bool> isTenantAvailable(String tenantName) async {
    final data = await _api.isTenantAvailable({'tenancyName': tenantName});
    final result = (data['result'] ?? data) as Map<String, dynamic>;
    final tenantId = result['tenantId'];
    return tenantId == null;
  }

  Future<String> registerTenantAndAuthenticate({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String tenantName,
  }) async {
    final editionId = await getDefaultEditionId();

    await _api.registerTenant(kDefaultTimeZone, {
      'adminEmailAddress': email,
      'adminFirstName': firstName,
      'adminLastName': lastName,
      'adminPassword': password,
      'captchaResponse': null,
      'editionId': editionId,
      'name': tenantName,
      'tenancyName': tenantName,
    });

    final authResponse = await _api.authenticate({
      'ianaTimeZone': kDefaultTimeZone,
      'password': password,
      'rememberClient': false,
      'returnUrl': null,
      'singleSignIn': false,
      'tenantName': tenantName,
      'userNameOrEmailAddress': email,
    });

    final result = (authResponse['result'] ?? authResponse) as Map<String, dynamic>;
    final token = result['accessToken'] as String?;
    if (token == null) {
      throw Exception('Missing access token');
    }

    await _storage.write(key: kAuthTokenKey, value: token);
    return token;
  }
}
