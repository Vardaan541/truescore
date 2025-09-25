import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../screens/onboarding_screen.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          _buildIcon(),
          SizedBox(height: 48.h),
          // Title
          _buildTitle(),
          SizedBox(height: 16.h),
          // Description
          _buildDescription(),
          SizedBox(height: 32.h),
          // Additional Features for Last Page
          if (isLastPage) _buildAdditionalFeatures(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AccessibilityTheme.isHighContrast
                ? null
                : LinearGradient(
                    colors: [data.color, data.color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: AccessibilityTheme.isHighContrast
                ? AccessibilityTheme.getAccessibleColor(data.color)
                : null,
            boxShadow: [
              BoxShadow(
                color: data.color.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            data.icon,
            size: AccessibilityTheme.getAccessibleIconSize(60),
            color: AccessibilityTheme.isHighContrast
                ? AppTheme.highContrastBackground
                : AppTheme.backgroundDark,
          ),
        )
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 600.ms);
  }

  Widget _buildTitle() {
    return Text(
          data.title,
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AccessibilityTheme.getAccessibleColor(data.color),
          ),
          textAlign: TextAlign.center,
        )
        .animate()
        .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 200.ms)
        .fadeIn(duration: 600.ms, delay: 200.ms);
  }

  Widget _buildDescription() {
    return Text(
          data.description,
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
            lineHeight: 1.5,
          ),
          textAlign: TextAlign.center,
        )
        .animate()
        .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 400.ms)
        .fadeIn(duration: 600.ms, delay: 400.ms);
  }

  Widget _buildAdditionalFeatures() {
    return Column(
          children: [
            // Accessibility Features
            _buildFeatureItem(
              icon: Icons.accessibility,
              title: 'Accessibility First',
              description:
                  'Voice guidance, large fonts, and high contrast modes',
            ),
            SizedBox(height: 16.h),
            _buildFeatureItem(
              icon: Icons.psychology,
              title: 'AI-Powered',
              description: 'Smart recommendations and performance analysis',
            ),
            SizedBox(height: 16.h),
            _buildFeatureItem(
              icon: Icons.group,
              title: 'Community Driven',
              description: 'Connect with athletes, coaches, and scouts',
            ),
          ],
        )
        .animate()
        .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 600.ms)
        .fadeIn(duration: 600.ms, delay: 600.ms);
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
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
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AccessibilityTheme.getAccessibleColor(
                data.color,
              ).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: AccessibilityTheme.getAccessibleIconSize(20),
              color: AccessibilityTheme.getAccessibleColor(data.color),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.highContrastForeground,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

