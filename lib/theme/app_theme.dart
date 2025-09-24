import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryNavy = Color(0xFF19183B);
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color primaryBlue = Color(0xFF3B82F6);

  // Athlete Theme Colors (Neon gradients)
  static const Color athletePrimary = Color(0xFF00F5FF);
  static const Color athleteSecondary = Color(0xFF8B5CF6);
  static const Color athleteAccent = Color(0xFF10B981);

  // Official Theme Colors
  static const Color officialPrimary = Color(0xFF19183B);
  static const Color officialSecondary = Color(0xFFFFD700);
  static const Color officialAccent = Color(0xFF3B82F6);

  // Accessibility Colors
  static const Color highContrastBackground = Color(0xFF000000);
  static const Color highContrastForeground = Color(0xFFFFFFFF);
  static const Color colorBlindFriendly1 = Color(0xFF1F77B4);
  static const Color colorBlindFriendly2 = Color(0xFFFF7F0E);
  static const Color colorBlindFriendly3 = Color(0xFF2CA02C);

  // Neutral Colors
  static const Color backgroundDark = Color(0xFF1A1A1A);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceDark = Color(0xFF2D2D2D);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Athlete Theme
  static ThemeData get athleteTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: athletePrimary,
        secondary: athleteSecondary,
        tertiary: athleteAccent,
        surface: surfaceDark,
        background: backgroundDark,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: athletePrimary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      textTheme: _buildAthleteTextTheme(),
      cardTheme: CardThemeData(
        color: surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 4,
      ),
    );
  }

  // Official Theme
  static ThemeData get officialTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: officialPrimary,
        secondary: officialSecondary,
        tertiary: officialAccent,
        surface: surfaceDark,
        background: backgroundDark,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: officialSecondary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      textTheme: _buildOfficialTextTheme(),
      cardTheme: CardThemeData(
        color: surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 4,
      ),
    );
  }

  // High Contrast Theme for Accessibility
  static ThemeData get highContrastTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: highContrastForeground,
        secondary: highContrastForeground,
        surface: highContrastBackground,
        background: highContrastBackground,
        onPrimary: highContrastBackground,
        onSecondary: highContrastBackground,
        onSurface: highContrastForeground,
        onBackground: highContrastForeground,
      ),
      scaffoldBackgroundColor: highContrastBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: highContrastBackground,
        foregroundColor: highContrastForeground,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: highContrastForeground,
          foregroundColor: highContrastBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      textTheme: _buildHighContrastTextTheme(),
      cardTheme: CardThemeData(
        color: highContrastBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: highContrastForeground, width: 2),
        ),
        elevation: 0,
      ),
    );
  }

  // Color Blind Friendly Theme
  static ThemeData get colorBlindFriendlyTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: colorBlindFriendly1,
        secondary: colorBlindFriendly2,
        tertiary: colorBlindFriendly3,
        surface: surfaceDark,
        background: backgroundDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBlindFriendly1,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      textTheme: _buildColorBlindFriendlyTextTheme(),
      cardTheme: CardThemeData(
        color: surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 4,
      ),
    );
  }

  static TextTheme _buildAthleteTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: athletePrimary,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: athletePrimary,
        letterSpacing: 0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: athletePrimary,
        letterSpacing: 0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: textSecondary,
        letterSpacing: 0.1,
      ),
    );
  }

  static TextTheme _buildOfficialTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: officialSecondary,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: officialSecondary,
        letterSpacing: 0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: officialSecondary,
        letterSpacing: 0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: textSecondary,
        letterSpacing: 0.1,
      ),
    );
  }

  static TextTheme _buildHighContrastTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: highContrastForeground,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: highContrastForeground,
        letterSpacing: 0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: highContrastForeground,
        letterSpacing: 0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: highContrastForeground,
        letterSpacing: 0.3,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: highContrastForeground,
        letterSpacing: 0.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: highContrastForeground,
        letterSpacing: 0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: highContrastForeground,
        letterSpacing: 0.2,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: highContrastForeground,
        letterSpacing: 0.2,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: highContrastForeground,
        letterSpacing: 0.2,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: highContrastForeground,
        letterSpacing: 0.1,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: highContrastForeground,
        letterSpacing: 0.1,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: highContrastForeground,
        letterSpacing: 0.1,
      ),
    );
  }

  static TextTheme _buildColorBlindFriendlyTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: colorBlindFriendly1,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: colorBlindFriendly1,
        letterSpacing: 0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: colorBlindFriendly1,
        letterSpacing: 0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: textSecondary,
        letterSpacing: 0.1,
      ),
    );
  }

  // Gradient definitions
  static const LinearGradient athleteGradient = LinearGradient(
    colors: [athletePrimary, athleteSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient officialGradient = LinearGradient(
    colors: [officialPrimary, officialSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient holographicGradient = LinearGradient(
    colors: [
      Color(0xFF00F5FF),
      Color(0xFF8B5CF6),
      Color(0xFF10B981),
      Color(0xFFFFD700),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Border radius
  static BorderRadius get smallRadius => BorderRadius.circular(8.r);
  static BorderRadius get mediumRadius => BorderRadius.circular(12.r);
  static BorderRadius get largeRadius => BorderRadius.circular(16.r);
  static BorderRadius get extraLargeRadius => BorderRadius.circular(24.r);

  // Spacing
  static double get smallSpacing => 8.w;
  static double get mediumSpacing => 16.w;
  static double get largeSpacing => 24.w;
  static double get extraLargeSpacing => 32.w;

  // Icon sizes
  static double get smallIcon => 16.w;
  static double get mediumIcon => 24.w;
  static double get largeIcon => 32.w;
  static double get extraLargeIcon => 48.w;
}
