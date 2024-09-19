import 'package:aidmanager_mobile/config/router/app_router.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AidManager',
      debugShowCheckedModeBanner: false,
      theme: MainTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
