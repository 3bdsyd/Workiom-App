// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => AuthResult(
  accessToken: json['accessToken'] as String,
  encryptedAccessToken: json['encryptedAccessToken'] as String,
  expireInSeconds: (json['expireInSeconds'] as num).toInt(),
  shouldResetPassword: json['shouldResetPassword'] as bool?,
  passwordResetCode: json['passwordResetCode'] as String?,
  passwordExpired: json['passwordExpired'] as bool?,
  userId: (json['userId'] as num?)?.toInt(),
  requiresTwoFactorVerification: json['requiresTwoFactorVerification'] as bool?,
  returnUrl: json['returnUrl'] as String?,
  refreshToken: json['refreshToken'] as String?,
  refreshTokenExpireInSeconds: (json['refreshTokenExpireInSeconds'] as num?)
      ?.toInt(),
);

Map<String, dynamic> _$AuthResultToJson(AuthResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'encryptedAccessToken': instance.encryptedAccessToken,
      'expireInSeconds': instance.expireInSeconds,
      'shouldResetPassword': instance.shouldResetPassword,
      'passwordResetCode': instance.passwordResetCode,
      'passwordExpired': instance.passwordExpired,
      'userId': instance.userId,
      'requiresTwoFactorVerification': instance.requiresTwoFactorVerification,
      'returnUrl': instance.returnUrl,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpireInSeconds': instance.refreshTokenExpireInSeconds,
    };
