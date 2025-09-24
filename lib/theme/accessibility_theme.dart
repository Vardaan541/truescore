import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_theme.dart';

class AccessibilityTheme {
  static const double baseFontSize = 16.0;
  static const double largeFontSize = 20.0;
  static const double extraLargeFontSize = 24.0;

  // High contrast color combinations
  static const Color highContrastPrimary = Color(0xFFFFFFFF);
  static const Color highContrastSecondary = Color(0xFF000000);
  static const Color highContrastAccent = Color(0xFFFF0000);

  // Color blind friendly palette
  static const List<Color> colorBlindFriendlyPalette = [
    Color(0xFF1F77B4), // Blue
    Color(0xFFFF7F0E), // Orange
    Color(0xFF2CA02C), // Green
    Color(0xFFD62728), // Red
    Color(0xFF9467BD), // Purple
    Color(0xFF8C564B), // Brown
    Color(0xFFE377C2), // Pink
    Color(0xFF7F7F7F), // Gray
  ];

  // Accessibility settings
  static bool isHighContrast = false;
  static bool isLargeFont = false;
  static bool isColorBlindFriendly = false;
  static bool isTextToSpeech = false;
  static double fontSizeMultiplier = 1.0;

  // Update accessibility settings
  static void updateAccessibilitySettings({
    bool? highContrast,
    bool? largeFont,
    bool? colorBlindFriendly,
    bool? textToSpeech,
    double? fontSizeMultiplier,
  }) {
    isHighContrast = highContrast ?? isHighContrast;
    isLargeFont = largeFont ?? isLargeFont;
    isColorBlindFriendly = colorBlindFriendly ?? isColorBlindFriendly;
    isTextToSpeech = textToSpeech ?? isTextToSpeech;
    AccessibilityTheme.fontSizeMultiplier =
        fontSizeMultiplier ?? AccessibilityTheme.fontSizeMultiplier;
  }

  // Get accessible color based on settings
  static Color getAccessibleColor(Color originalColor) {
    if (isHighContrast) {
      return _getHighContrastColor(originalColor);
    }
    if (isColorBlindFriendly) {
      return _getColorBlindFriendlyColor(originalColor);
    }
    return originalColor;
  }

  static Color _getHighContrastColor(Color originalColor) {
    // Convert to high contrast version
    if (originalColor == AppTheme.athletePrimary) {
      return highContrastPrimary;
    }
    if (originalColor == AppTheme.officialSecondary) {
      return highContrastPrimary;
    }
    if (originalColor == AppTheme.backgroundDark) {
      return highContrastSecondary;
    }
    return originalColor;
  }

  static Color _getColorBlindFriendlyColor(Color originalColor) {
    // Map to color blind friendly palette
    if (originalColor == AppTheme.athletePrimary) {
      return colorBlindFriendlyPalette[0];
    }
    if (originalColor == AppTheme.athleteSecondary) {
      return colorBlindFriendlyPalette[1];
    }
    if (originalColor == AppTheme.athleteAccent) {
      return colorBlindFriendlyPalette[2];
    }
    return originalColor;
  }

  // Get accessible font size
  static double getAccessibleFontSize(double baseSize) {
    double multiplier = fontSizeMultiplier;
    if (isLargeFont) {
      multiplier *= 1.25;
    }
    return (baseSize * multiplier).sp;
  }

  // Get accessible spacing
  static double getAccessibleSpacing(double baseSpacing) {
    if (isLargeFont) {
      return (baseSpacing * 1.2).w;
    }
    return baseSpacing.w;
  }

  // Get accessible icon size
  static double getAccessibleIconSize(double baseSize) {
    if (isLargeFont) {
      return (baseSize * 1.2).w;
    }
    return baseSize.w;
  }

  // Create accessible text style
  static TextStyle createAccessibleTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? letterSpacing,
    double? lineHeight,
  }) {
    return TextStyle(
      fontSize: getAccessibleFontSize(fontSize),
      fontWeight: fontWeight,
      color: getAccessibleColor(color),
      letterSpacing: letterSpacing,
      height: lineHeight,
    );
  }

  // Create accessible button style
  static ButtonStyle createAccessibleButtonStyle({
    required Color backgroundColor,
    required Color foregroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: getAccessibleColor(backgroundColor),
      foregroundColor: getAccessibleColor(foregroundColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getAccessibleSpacing(borderRadius ?? 12.0),
        ),
      ),
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: getAccessibleSpacing(16.0),
            vertical: getAccessibleSpacing(12.0),
          ),
    );
  }

  // Create accessible card style
  static CardTheme createAccessibleCardTheme() {
    return CardTheme(
      color: getAccessibleColor(AppTheme.surfaceDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getAccessibleSpacing(16.0)),
        side: isHighContrast
            ? BorderSide(
                color: getAccessibleColor(AppTheme.highContrastForeground),
                width: 2,
              )
            : BorderSide.none,
      ),
      elevation: isHighContrast ? 0 : 4,
    );
  }

  // Create accessible input decoration
  static InputDecoration createAccessibleInputDecoration({
    required String labelText,
    String? hintText,
    Color? borderColor,
    Color? focusedBorderColor,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: createAccessibleTextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: getAccessibleColor(AppTheme.textSecondary),
      ),
      hintStyle: createAccessibleTextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: getAccessibleColor(AppTheme.textDisabled),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(getAccessibleSpacing(12.0)),
        borderSide: BorderSide(
          color: getAccessibleColor(borderColor ?? AppTheme.textSecondary),
          width: isHighContrast ? 2 : 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(getAccessibleSpacing(12.0)),
        borderSide: BorderSide(
          color: getAccessibleColor(borderColor ?? AppTheme.textSecondary),
          width: isHighContrast ? 2 : 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(getAccessibleSpacing(12.0)),
        borderSide: BorderSide(
          color: getAccessibleColor(focusedBorderColor ?? AppTheme.primaryBlue),
          width: isHighContrast ? 3 : 2,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: getAccessibleSpacing(16.0),
        vertical: getAccessibleSpacing(16.0),
      ),
    );
  }

  // Create accessible app bar theme
  static AppBarTheme createAccessibleAppBarTheme() {
    return AppBarTheme(
      backgroundColor: getAccessibleColor(AppTheme.backgroundDark),
      foregroundColor: getAccessibleColor(AppTheme.highContrastForeground),
      elevation: 0,
      titleTextStyle: createAccessibleTextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: getAccessibleColor(AppTheme.highContrastForeground),
      ),
      toolbarHeight: getAccessibleSpacing(56.0),
    );
  }

  // Create accessible bottom navigation bar theme
  static BottomNavigationBarThemeData createAccessibleBottomNavTheme() {
    return BottomNavigationBarThemeData(
      backgroundColor: getAccessibleColor(AppTheme.backgroundDark),
      selectedItemColor: getAccessibleColor(AppTheme.athletePrimary),
      unselectedItemColor: getAccessibleColor(AppTheme.textSecondary),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: createAccessibleTextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: getAccessibleColor(AppTheme.athletePrimary),
      ),
      unselectedLabelStyle: createAccessibleTextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: getAccessibleColor(AppTheme.textSecondary),
      ),
    );
  }

  // Create accessible floating action button theme
  static FloatingActionButtonThemeData createAccessibleFABTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: getAccessibleColor(AppTheme.athletePrimary),
      foregroundColor: getAccessibleColor(AppTheme.highContrastBackground),
      elevation: isHighContrast ? 0 : 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getAccessibleSpacing(16.0)),
        side: isHighContrast
            ? BorderSide(
                color: getAccessibleColor(AppTheme.highContrastForeground),
                width: 2,
              )
            : BorderSide.none,
      ),
    );
  }

  // Create accessible divider theme
  static DividerThemeData createAccessibleDividerTheme() {
    return DividerThemeData(
      color: getAccessibleColor(AppTheme.textSecondary),
      thickness: isHighContrast ? 2 : 1,
      space: getAccessibleSpacing(16.0),
    );
  }

  // Create accessible switch theme
  static SwitchThemeData createAccessibleSwitchTheme() {
    return SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return getAccessibleColor(AppTheme.athletePrimary);
        }
        return getAccessibleColor(AppTheme.textSecondary);
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return getAccessibleColor(AppTheme.athletePrimary).withOpacity(0.3);
        }
        return getAccessibleColor(AppTheme.textSecondary).withOpacity(0.3);
      }),
    );
  }

  // Create accessible checkbox theme
  static CheckboxThemeData createAccessibleCheckboxTheme() {
    return CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return getAccessibleColor(AppTheme.athletePrimary);
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(
        getAccessibleColor(AppTheme.highContrastBackground),
      ),
      side: BorderSide(
        color: getAccessibleColor(AppTheme.textSecondary),
        width: isHighContrast ? 2 : 1,
      ),
    );
  }

  // Create accessible radio theme
  static RadioThemeData createAccessibleRadioTheme() {
    return RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return getAccessibleColor(AppTheme.athletePrimary);
        }
        return getAccessibleColor(AppTheme.textSecondary);
      }),
    );
  }

  // Create accessible slider theme
  static SliderThemeData createAccessibleSliderTheme() {
    return SliderThemeData(
      activeTrackColor: getAccessibleColor(AppTheme.athletePrimary),
      inactiveTrackColor: getAccessibleColor(AppTheme.textSecondary),
      thumbColor: getAccessibleColor(AppTheme.athletePrimary),
      overlayColor: getAccessibleColor(
        AppTheme.athletePrimary,
      ).withOpacity(0.2),
      trackHeight: isHighContrast ? 6 : 4,
    );
  }

  // Create accessible progress indicator theme
  static ProgressIndicatorThemeData createAccessibleProgressTheme() {
    return ProgressIndicatorThemeData(
      color: getAccessibleColor(AppTheme.athletePrimary),
      linearTrackColor: getAccessibleColor(AppTheme.textSecondary),
      circularTrackColor: getAccessibleColor(AppTheme.textSecondary),
    );
  }

  // Create accessible chip theme
  static ChipThemeData createAccessibleChipTheme() {
    return ChipThemeData(
      backgroundColor: getAccessibleColor(AppTheme.surfaceDark),
      labelStyle: createAccessibleTextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: getAccessibleColor(AppTheme.highContrastForeground),
      ),
      side: BorderSide(
        color: getAccessibleColor(AppTheme.textSecondary),
        width: isHighContrast ? 2 : 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getAccessibleSpacing(16.0)),
      ),
    );
  }

  // Create accessible tooltip theme
  static TooltipThemeData createAccessibleTooltipTheme() {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: getAccessibleColor(AppTheme.surfaceDark),
        borderRadius: BorderRadius.circular(getAccessibleSpacing(8.0)),
        border: isHighContrast
            ? Border.all(
                color: getAccessibleColor(AppTheme.highContrastForeground),
                width: 1,
              )
            : null,
      ),
      textStyle: createAccessibleTextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: getAccessibleColor(AppTheme.highContrastForeground),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getAccessibleSpacing(8.0),
        vertical: getAccessibleSpacing(4.0),
      ),
    );
  }
}
