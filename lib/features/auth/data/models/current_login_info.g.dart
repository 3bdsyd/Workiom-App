// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentLoginInfo _$CurrentLoginInfoFromJson(Map<String, dynamic> json) =>
    CurrentLoginInfo(
      user: json['user'] == null
          ? null
          : LoginUser.fromJson(json['user'] as Map<String, dynamic>),
      tenant: json['tenant'] == null
          ? null
          : LoginTenant.fromJson(json['tenant'] as Map<String, dynamic>),
      application: ApplicationInfo.fromJson(
        json['application'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CurrentLoginInfoToJson(CurrentLoginInfo instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tenant': instance.tenant,
      'application': instance.application,
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  surname: json['surname'] as String,
  userName: json['userName'] as String,
  emailAddress: json['emailAddress'] as String,
);

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'surname': instance.surname,
  'userName': instance.userName,
  'emailAddress': instance.emailAddress,
};

LoginTenant _$LoginTenantFromJson(Map<String, dynamic> json) => LoginTenant(
  id: (json['id'] as num).toInt(),
  tenancyName: json['tenancyName'] as String,
  name: json['name'] as String,
  edition: json['edition'] == null
      ? null
      : TenantEdition.fromJson(json['edition'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginTenantToJson(LoginTenant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenancyName': instance.tenancyName,
      'name': instance.name,
      'edition': instance.edition,
    };

TenantEdition _$TenantEditionFromJson(Map<String, dynamic> json) =>
    TenantEdition(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$TenantEditionToJson(TenantEdition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
    };

ApplicationInfo _$ApplicationInfoFromJson(Map<String, dynamic> json) =>
    ApplicationInfo(
      version: json['version'] as String,
      releaseDate: json['releaseDate'] as String,
      currency: json['currency'] as String?,
      currencySign: json['currencySign'] as String?,
    );

Map<String, dynamic> _$ApplicationInfoToJson(ApplicationInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
      'releaseDate': instance.releaseDate,
      'currency': instance.currency,
      'currencySign': instance.currencySign,
    };
