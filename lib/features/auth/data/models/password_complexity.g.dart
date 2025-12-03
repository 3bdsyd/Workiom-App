// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_complexity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordComplexitySetting _$PasswordComplexitySettingFromJson(
  Map<String, dynamic> json,
) => PasswordComplexitySetting(
  requireDigit: json['requireDigit'] as bool,
  requireLowercase: json['requireLowercase'] as bool,
  requireNonAlphanumeric: json['requireNonAlphanumeric'] as bool,
  requireUppercase: json['requireUppercase'] as bool,
  requiredLength: (json['requiredLength'] as num).toInt(),
);

Map<String, dynamic> _$PasswordComplexitySettingToJson(
  PasswordComplexitySetting instance,
) => <String, dynamic>{
  'requireDigit': instance.requireDigit,
  'requireLowercase': instance.requireLowercase,
  'requireNonAlphanumeric': instance.requireNonAlphanumeric,
  'requireUppercase': instance.requireUppercase,
  'requiredLength': instance.requiredLength,
};
