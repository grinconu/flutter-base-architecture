import 'package:base_architecture/core/di/injection.dart';
import 'package:base_architecture/core/router/app_router.dart';
import 'package:base_architecture/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Base Architecture',
      theme: AppTheme.getTheme(),
      routerConfig: appRouter,
    );
  }
}