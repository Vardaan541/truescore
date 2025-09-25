import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../utils/navigation_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Notification settings
  bool _eventReminders = true;
  bool _challengeUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundDark,
        foregroundColor: AppTheme.highContrastForeground,
        elevation: 0,
        title: Text(
          'Settings',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Account Section
            _buildAccountSection(),
            SizedBox(height: 24.h),

            // Accessibility Section
            _buildAccessibilitySection(),
            SizedBox(height: 24.h),

            // Notifications Section
            _buildNotificationsSection(),
            SizedBox(height: 32.h),

            // Logout Button
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Account',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.highContrastForeground,
              ),
            ),
          ),

          // Edit Profile Option
          _buildAccountOption(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              _showEditProfileDialog();
            },
          ),

          // Divider
          Divider(
            color: AppTheme.textSecondary.withOpacity(0.3),
            thickness: 0.5,
            height: 1,
          ),

          // Change Password Option
          _buildAccountOption(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              _showChangePasswordDialog();
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildAccessibilitySection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Accessibility',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.highContrastForeground,
              ),
            ),
          ),

          // High Contrast Mode Toggle
          _buildToggleOption(
            icon: Icons.contrast,
            title: 'High Contrast Mode',
            value: AccessibilityTheme.isHighContrast,
            onChanged: (value) {
              setState(() {
                AccessibilityTheme.updateAccessibilitySettings(
                  highContrast: value,
                );
              });
            },
          ),

          // Divider
          Divider(
            color: AppTheme.textSecondary.withOpacity(0.3),
            thickness: 0.5,
            height: 1,
          ),

          // Large Fonts Toggle
          _buildToggleOption(
            icon: Icons.text_fields,
            title: 'Large Fonts',
            value: AccessibilityTheme.isLargeFont,
            onChanged: (value) {
              setState(() {
                AccessibilityTheme.updateAccessibilitySettings(
                  largeFont: value,
                );
              });
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildNotificationsSection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Notifications',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.highContrastForeground,
              ),
            ),
          ),

          // Event Reminders Toggle
          _buildToggleOption(
            icon: Icons.event_note,
            title: 'Event Reminders',
            value: _eventReminders,
            onChanged: (value) {
              setState(() {
                _eventReminders = value;
              });
            },
          ),

          // Divider
          Divider(
            color: AppTheme.textSecondary.withOpacity(0.3),
            thickness: 0.5,
            height: 1,
          ),

          // Challenge Updates Toggle
          _buildToggleOption(
            icon: Icons.emoji_events,
            title: 'Challenge Updates',
            value: _challengeUpdates,
            onChanged: (value) {
              setState(() {
                _challengeUpdates = value;
              });
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildAccountOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary),
        size: AccessibilityTheme.getAccessibleIconSize(24),
      ),
      title: Text(
        title,
        style: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.highContrastForeground,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppTheme.textSecondary,
        size: AccessibilityTheme.getAccessibleIconSize(16),
      ),
      onTap: onTap,
    );
  }

  Widget _buildToggleOption({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary),
        size: AccessibilityTheme.getAccessibleIconSize(24),
      ),
      title: Text(
        title,
        style: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.highContrastForeground,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AccessibilityTheme.getAccessibleColor(
          AppTheme.athletePrimary,
        ),
        activeTrackColor: AccessibilityTheme.getAccessibleColor(
          AppTheme.athletePrimary,
        ).withOpacity(0.3),
        inactiveThumbColor: AppTheme.textSecondary,
        inactiveTrackColor: AppTheme.textSecondary.withOpacity(0.3),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: AppTheme.error,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.error.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: _showLogoutDialog,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Logout',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.star,
                color: Colors.white,
                size: AccessibilityTheme.getAccessibleIconSize(20),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0);
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Edit Profile',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
              ),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              decoration: AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              decoration: AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'Phone',
                hintText: 'Enter your phone number',
              ),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessSnackBar('Profile updated successfully!');
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.athletePrimary,
              foregroundColor: AppTheme.backgroundDark,
            ),
            child: Text(
              'Save',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.backgroundDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Change Password',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'Current Password',
                hintText: 'Enter current password',
              ),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              obscureText: true,
              decoration: AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'New Password',
                hintText: 'Enter new password',
              ),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              obscureText: true,
              decoration: AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'Confirm New Password',
                hintText: 'Confirm new password',
              ),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessSnackBar('Password changed successfully!');
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.athletePrimary,
              foregroundColor: AppTheme.backgroundDark,
            ),
            child: Text(
              'Change Password',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.backgroundDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Logout',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout();
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.error,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Logout',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    // TODO: Implement actual logout logic
    // For now, just show a success message
    _showSuccessSnackBar('Logged out successfully!');

    // Navigate back to login screen
    Future.delayed(const Duration(seconds: 1), () {
      NavigationUtils.navigateToLogin(context);
    });
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
