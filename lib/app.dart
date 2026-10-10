import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/onboarding_screen.dart';

class SamirNetApp extends StatefulWidget {
  const SamirNetApp({super.key});
  @override
  State<SamirNetApp> createState() => _SamirNetAppState();
}
class _SamirNetAppState extends State<SamirNetApp> {
  ThemeMode _mode = ThemeMode.system;
  void setTheme(ThemeMode mode) => setState(() => _mode = mode);
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'SamirNet Video',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: _mode,
    locale: const Locale('ar'),
    home: OnboardingScreen(onStart: () {}),
  );
}
