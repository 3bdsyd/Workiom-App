import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';

import 'core/app_theme.dart';
import 'core/di/service_locator.dart';
import 'core/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    DevicePreview(enabled: false, builder: (context) => const WorkiomApp()),
  );
}

class WorkiomApp extends StatelessWidget {
  const WorkiomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 829),
      minTextAdapt: true,
      builder: (_, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Workiom Test',
          theme: AppTheme.light,
          routerConfig: appRouter,
          useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,
        );
      },
    );
  }
}
