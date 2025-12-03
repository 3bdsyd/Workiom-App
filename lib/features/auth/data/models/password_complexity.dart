import 'package:json_annotation/json_annotation.dart';

part 'password_complexity.g.dart';

@JsonSerializable()
class PasswordComplexitySetting {
  const PasswordComplexitySetting({
    required this.requireDigit,
    required this.requireLowercase,
    required this.requireNonAlphanumeric,
    required this.requireUppercase,
    required this.requiredLength,
  });

  final bool requireDigit;
  final bool requireLowercase;
  final bool requireNonAlphanumeric;
  final bool requireUppercase;
  final int requiredLength;

  factory PasswordComplexitySetting.fromJson(Map<String, dynamic> json) =>
      _$PasswordComplexitySettingFromJson(json);
}
