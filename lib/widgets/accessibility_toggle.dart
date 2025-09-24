import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';

class AccessibilityToggle extends StatefulWidget {
  const AccessibilityToggle({super.key});

  @override
  State<AccessibilityToggle> createState() => _AccessibilityToggleState();
}

class _AccessibilityToggleState extends State<AccessibilityToggle> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleHighContrast() {
    setState(() {
      AccessibilityTheme.updateAccessibilitySettings(
        highContrast: !AccessibilityTheme.isHighContrast,
      );
    });
  }

  void _toggleLargeFont() {
    setState(() {
      AccessibilityTheme.updateAccessibilitySettings(
        largeFont: !AccessibilityTheme.isLargeFont,
      );
    });
  }

  void _toggleColorBlindFriendly() {
    setState(() {
      AccessibilityTheme.updateAccessibilitySettings(
        colorBlindFriendly: !AccessibilityTheme.isColorBlindFriendly,
      );
    });
  }

  void _toggleTextToSpeech() {
    setState(() {
      AccessibilityTheme.updateAccessibilitySettings(
        textToSpeech: !AccessibilityTheme.isTextToSpeech,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          // Header
          ListTile(
            leading: Icon(
              Icons.accessibility,
              color: AccessibilityTheme.getAccessibleColor(
                AppTheme.athletePrimary,
              ),
              size: AccessibilityTheme.getAccessibleIconSize(24),
            ),
            title: Text(
              'Accessibility Settings',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.highContrastForeground,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: AppTheme.textSecondary,
              size: AccessibilityTheme.getAccessibleIconSize(24),
            ),
            onTap: _toggleExpansion,
          ),
          // Expanded Content
          if (_isExpanded) ...[
            Divider(
              color: AppTheme.textSecondary,
              thickness: AccessibilityTheme.isHighContrast ? 2 : 1,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // High Contrast Toggle
                  _buildToggleTile(
                    title: 'High Contrast Mode',
                    subtitle: 'Increase contrast for better visibility',
                    value: AccessibilityTheme.isHighContrast,
                    onChanged: _toggleHighContrast,
                    icon: Icons.contrast,
                  ),
                  SizedBox(height: 12.h),
                  // Large Font Toggle
                  _buildToggleTile(
                    title: 'Large Font Mode',
                    subtitle: 'Increase text size for better readability',
                    value: AccessibilityTheme.isLargeFont,
                    onChanged: _toggleLargeFont,
                    icon: Icons.text_fields,
                  ),
                  SizedBox(height: 12.h),
                  // Color Blind Friendly Toggle
                  _buildToggleTile(
                    title: 'Color Blind Friendly',
                    subtitle: 'Use color blind friendly palette',
                    value: AccessibilityTheme.isColorBlindFriendly,
                    onChanged: _toggleColorBlindFriendly,
                    icon: Icons.palette,
                  ),
                  SizedBox(height: 12.h),
                  // Text to Speech Toggle
                  _buildToggleTile(
                    title: 'Text to Speech',
                    subtitle: 'Enable voice feedback',
                    value: AccessibilityTheme.isTextToSpeech,
                    onChanged: _toggleTextToSpeech,
                    icon: Icons.record_voice_over,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required bool value,
    required VoidCallback onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: value
            ? AccessibilityTheme.getAccessibleColor(
                AppTheme.athletePrimary,
              ).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: value
            ? Border.all(
                color: AccessibilityTheme.getAccessibleColor(
                  AppTheme.athletePrimary,
                ),
                width: 1,
              )
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AccessibilityTheme.getAccessibleColor(
              AppTheme.athletePrimary,
            ),
            size: AccessibilityTheme.getAccessibleIconSize(20),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.highContrastForeground,
                  ),
                ),
                Text(
                  subtitle,
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) => onChanged(),
            activeColor: AccessibilityTheme.getAccessibleColor(
              AppTheme.athletePrimary,
            ),
            inactiveThumbColor: AppTheme.textSecondary,
            inactiveTrackColor: AppTheme.textSecondary.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
