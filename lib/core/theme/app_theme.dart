import 'package:flutter/material.dart';
class AppColors {
  static const coral = Color(0xFFEF4444);
  static const amber = Color(0xFFF59E0B);
  static const ink = Color(0xFF111827);
  static const muted = Color(0xFF6B7280);
  static const card = Color(0xFFF8FAFC);
  static const border = Color(0xFFE5E7EB);
}
class AppTheme {
  static ThemeData get light => _make(Brightness.light);
  static ThemeData get dark => _make(Brightness.dark);
  static ThemeData _make(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(seedColor: AppColors.coral, brightness: brightness, primary: AppColors.coral, secondary: AppColors.amber);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.ink : Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: isDark ? AppColors.ink : Colors.white, foregroundColor: isDark ? Colors.white : AppColors.ink, elevation: 0),
      cardTheme: CardThemeData(color: isDark ? const Color(0xFF1F2937) : AppColors.card, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isDark ? const Color(0xFF374151) : AppColors.border))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: isDark ? const Color(0xFF1F2937) : AppColors.card, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15)),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: AppColors.coral, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), textStyle: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}