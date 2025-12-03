import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants.dart';
import '../../features/auth/data/auth_api_service.dart';
import '../../features/auth/data/auth_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: true,
    ),
  );

  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<Dio>(), baseUrl: kBaseUrl),
  );

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthApiService>(), getIt<FlutterSecureStorage>()),
  );
}
