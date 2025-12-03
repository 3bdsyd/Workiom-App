import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @GET('/api/services/app/Session/GetCurrentLoginInformations')
  Future<dynamic> getCurrentLoginInfos();

  @GET('/api/services/app/TenantRegistration/GetEditionsForSelect')
  Future<dynamic> getEditionsForSelect();

  @GET('/api/services/app/Profile/GetPasswordComplexitySetting')
  Future<dynamic> getPasswordComplexitySetting();

  @POST('/api/services/app/Account/IsTenantAvailable')
  Future<dynamic> isTenantAvailable(@Body() Map<String, dynamic> body);

  @POST('/api/services/app/TenantRegistration/RegisterTenant')
  Future<dynamic> registerTenant(
    @Query('timeZone') String timeZone,
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/TokenAuth/Authenticate')
  Future<dynamic> authenticate(@Body() Map<String, dynamic> body);
}
