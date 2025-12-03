import 'package:json_annotation/json_annotation.dart';

part 'current_login_info.g.dart';

@JsonSerializable()
class CurrentLoginInfo {
  const CurrentLoginInfo({
    this.user,
    this.tenant,
    required this.application,
  });

  final LoginUser? user;
  final LoginTenant? tenant;
  final ApplicationInfo application;

  factory CurrentLoginInfo.fromJson(Map<String, dynamic> json) =>
      _$CurrentLoginInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentLoginInfoToJson(this);
}

@JsonSerializable()
class LoginUser {
  const LoginUser({
    required this.id,
    required this.name,
    required this.surname,
    required this.userName,
    required this.emailAddress,
  });

  final int id;
  final String name;
  final String surname;
  final String userName;
  final String emailAddress;

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);
}

@JsonSerializable()
class LoginTenant {
  const LoginTenant({
    required this.id,
    required this.tenancyName,
    required this.name,
    this.edition,
  });

  final int id;
  final String tenancyName;
  final String name;
  final TenantEdition? edition;

  factory LoginTenant.fromJson(Map<String, dynamic> json) =>
      _$LoginTenantFromJson(json);

  Map<String, dynamic> toJson() => _$LoginTenantToJson(this);
}

@JsonSerializable()
class TenantEdition {
  const TenantEdition({
    required this.id,
    required this.name,
    required this.displayName,
  });

  final int id;
  final String name;
  final String displayName;

  factory TenantEdition.fromJson(Map<String, dynamic> json) =>
      _$TenantEditionFromJson(json);

  Map<String, dynamic> toJson() => _$TenantEditionToJson(this);
}

@JsonSerializable()
class ApplicationInfo {
  const ApplicationInfo({
    required this.version,
    required this.releaseDate,
    this.currency,
    this.currencySign,
  });

  final String version;
  final String releaseDate;
  final String? currency;
  final String? currencySign;

  factory ApplicationInfo.fromJson(Map<String, dynamic> json) =>
      _$ApplicationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationInfoToJson(this);
}
