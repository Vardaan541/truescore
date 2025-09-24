import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../utils/navigation_utils.dart';
import '../models/user.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole? _selectedRole;

  void _selectRole(UserRole role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _continueWithRole() {
    if (_selectedRole == null) return;

    switch (_selectedRole!) {
      case UserRole.athlete:
      case UserRole.paraAthlete:
        NavigationUtils.navigateToAthleteSignup(context, _selectedRole!);
        break;
      case UserRole.official:
        NavigationUtils.navigateToOfficialSignup(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              // Header
              _buildHeader(),
              SizedBox(height: 48.h),
              // Role Selection
              _buildRoleSelection(),
              SizedBox(height: 32.h),
              // Continue Button
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AccessibilityTheme.isHighContrast
                ? null
                : AppTheme.holographicGradient,
            color: AccessibilityTheme.isHighContrast
                ? AppTheme.highContrastForeground
                : null,
            boxShadow: [
              BoxShadow(
                color: AppTheme.athletePrimary.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            Icons.sports,
            size: AccessibilityTheme.getAccessibleIconSize(40),
            color: AccessibilityTheme.isHighContrast
                ? AppTheme.highContrastBackground
                : AppTheme.backgroundDark,
          ),
        ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.elasticOut,
        ),
        SizedBox(height: 16.h),
        // Title
        Text(
          'Choose Your Role',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.athletePrimary,
          ),
        ).animate().fadeIn(delay: 200.ms),
        SizedBox(height: 8.h),
        // Subtitle
        Text(
          'How would you like to use TrueScore?',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
          ),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      children: [
        // Athlete Option
        _buildRoleCard(
          role: UserRole.athlete,
          title: 'Athlete',
          description:
              'Track your performance, build your portfolio, and get discovered',
          icon: Icons.person,
          color: AppTheme.athletePrimary,
          gradient: AppTheme.athleteGradient,
        ),
        SizedBox(height: 16.h),
        // Para-Athlete Option
        _buildRoleCard(
          role: UserRole.paraAthlete,
          title: 'Para-Athlete',
          description:
              'Adaptive sports tracking with disability-aware features',
          icon: Icons.accessibility_new,
          color: AppTheme.athleteSecondary,
          gradient: LinearGradient(
            colors: [AppTheme.athleteSecondary, AppTheme.athleteAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        SizedBox(height: 16.h),
        // Official Option
        _buildRoleCard(
          role: UserRole.official,
          title: 'Official',
          description:
              'Coach, Judge, or Recruiter - Discover and evaluate talent',
          icon: Icons.business,
          color: AppTheme.officialSecondary,
          gradient: AppTheme.officialGradient,
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required UserRole role,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required Gradient gradient,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () => _selectRole(role),
      child: AnimatedContainer(
        duration: AppTheme.shortAnimation,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? (AccessibilityTheme.isHighContrast ? null : gradient)
              : null,
          color: isSelected
              ? (AccessibilityTheme.isHighContrast
                    ? AccessibilityTheme.getAccessibleColor(color)
                    : null)
              : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AccessibilityTheme.getAccessibleColor(color)
                : AppTheme.textSecondary,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AccessibilityTheme.getAccessibleColor(
                      color,
                    ).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected
                    ? (AccessibilityTheme.isHighContrast
                          ? null
                          : LinearGradient(
                              colors: [color, color.withOpacity(0.7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ))
                    : null,
                color: isSelected
                    ? (AccessibilityTheme.isHighContrast
                          ? AccessibilityTheme.getAccessibleColor(color)
                          : null)
                    : AppTheme.textSecondary,
              ),
              child: Icon(
                icon,
                size: AccessibilityTheme.getAccessibleIconSize(30),
                color: isSelected
                    ? (AccessibilityTheme.isHighContrast
                          ? AppTheme.highContrastBackground
                          : AppTheme.backgroundDark)
                    : AppTheme.backgroundDark,
              ),
            ),
            SizedBox(width: 16.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? (AccessibilityTheme.isHighContrast
                                ? AppTheme.highContrastBackground
                                : AppTheme.backgroundDark)
                          : AppTheme.highContrastForeground,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: isSelected
                          ? (AccessibilityTheme.isHighContrast
                                ? AppTheme.highContrastBackground
                                : AppTheme.backgroundDark)
                          : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Selection Indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AccessibilityTheme.isHighContrast
                    ? AppTheme.highContrastBackground
                    : AppTheme.backgroundDark,
                size: AccessibilityTheme.getAccessibleIconSize(24),
              ),
          ],
        ),
      ),
    ).animate().slideX(
      begin: role == UserRole.athlete
          ? -0.3
          : (role == UserRole.paraAthlete ? 0.3 : -0.3),
      end: 0,
      delay:
          (role == UserRole.athlete
                  ? 600
                  : (role == UserRole.paraAthlete ? 800 : 1000))
              .ms,
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        onPressed: _selectedRole != null ? _continueWithRole : null,
        style: AccessibilityTheme.createAccessibleButtonStyle(
          backgroundColor: _selectedRole != null
              ? AppTheme.athletePrimary
              : AppTheme.textDisabled,
          foregroundColor: _selectedRole != null
              ? AppTheme.backgroundDark
              : AppTheme.textSecondary,
          borderRadius: 12,
        ),
        child: Text(
          'Continue',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _selectedRole != null
                ? AppTheme.backgroundDark
                : AppTheme.textSecondary,
          ),
        ),
      ),
    ).animate().slideY(begin: 0.3, end: 0, delay: 1200.ms);
  }
}
