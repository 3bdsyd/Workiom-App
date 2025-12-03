import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:workiom_test_app/core/network/network_info.dart';

import '../constants.dart';
import '../../features/auth/data/auth_api_service.dart';
import '../../features/auth/data/auth_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // secure local storage
  final storage = const FlutterSecureStorage();

  // base Dio setup
  final dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  // pretty logger for requests
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: true,
    ),
  );

  // auto attach bearer token
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: kAuthTokenKey);
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );

  // DI registrations
  getIt.registerSingleton<FlutterSecureStorage>(storage);
  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  // retrofit API service
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<Dio>(), baseUrl: kBaseUrl),
  );

  // main repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      getIt<AuthApiService>(),
      getIt<FlutterSecureStorage>(),
      getIt<NetworkInfo>(),
    ),
  );
}
