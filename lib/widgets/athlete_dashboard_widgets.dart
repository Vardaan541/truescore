import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';

// Placeholder widget for athlete dashboard widgets
class AthleteDashboardWidgets {
  static Widget buildPlaceholder(String title) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12.r),
        border: AccessibilityTheme.isHighContrast
            ? Border.all(
                color: AccessibilityTheme.getAccessibleColor(
                  AppTheme.textSecondary,
                ),
                width: 1,
              )
            : null,
      ),
      child: Center(
        child: Text(
          '$title - Coming Soon',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
