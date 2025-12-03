import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @GET('/api/services/app/Session/GetCurrentLoginInformations')
  Future<Map<String, dynamic>> getCurrentLoginInfos();

  @GET('/api/services/app/TenantRegistration/GetEditionsForSelect')
  Future<Map<String, dynamic>> getEditionsForSelect();

  @GET('/api/services/app/Profile/GetPasswordComplexitySetting')
  Future<Map<String, dynamic>> getPasswordComplexitySetting();

  @POST('/api/services/app/Account/IsTenantAvailable')
  Future<Map<String, dynamic>> isTenantAvailable(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/services/app/TenantRegistration/RegisterTenant')
  Future<Map<String, dynamic>> registerTenant(
    @Query('timeZone') String timeZone,
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/TokenAuth/Authenticate')
  Future<Map<String, dynamic>> authenticate(
    @Body() Map<String, dynamic> body,
  );
}
