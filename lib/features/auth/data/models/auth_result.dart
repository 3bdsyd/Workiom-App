import 'package:json_annotation/json_annotation.dart';

part 'auth_result.g.dart';

@JsonSerializable()
class AuthResult {
  const AuthResult({
    required this.accessToken,
    required this.encryptedAccessToken,
    required this.expireInSeconds,
    this.shouldResetPassword,
    this.passwordResetCode,
    this.passwordExpired,
    this.userId,
    this.requiresTwoFactorVerification,
    this.returnUrl,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
  });

  final String accessToken;
  final String encryptedAccessToken;
  final int expireInSeconds;

  final bool? shouldResetPassword;
  final String? passwordResetCode;
  final bool? passwordExpired;
  final int? userId;
  final bool? requiresTwoFactorVerification;
  final String? returnUrl;

  final String? refreshToken;
  final int? refreshTokenExpireInSeconds;

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResultToJson(this);
}
