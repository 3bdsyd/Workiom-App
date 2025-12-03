import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_theme.dart';
import 'core/di/service_locator.dart';
import 'core/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const WorkiomApp());
}

class WorkiomApp extends StatelessWidget {
  const WorkiomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 829),
      minTextAdapt: true,
      builder: (_, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Workiom Test',
          theme: AppTheme.light,
          routerConfig: appRouter,
        );
      },
    );
  }
}
