import 'package:base_architecture/presentation/config/app_theme.dart';
import 'package:base_architecture/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App', // TODO: Change this to your app's name
      theme: AppTheme.getTheme(),
      home: const HomeScreen(),
    );
  }
}