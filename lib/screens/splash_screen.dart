import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../utils/navigation_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _loadingController;
  late Animation<double> _logoAnimation;
  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _loadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
    );
  }

  void _startSplashSequence() async {
    // Start logo animation
    _logoController.forward();

    // Wait a bit then start loading animation
    await Future.delayed(const Duration(milliseconds: 500));
    _loadingController.forward();

    // Wait for minimum splash duration
    await Future.delayed(const Duration(milliseconds: 2000));

    // Navigate to next screen
    if (mounted) {
      NavigationUtils.navigateToOnboarding(context);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.backgroundDark,
              AppTheme.primaryNavy,
              AppTheme.backgroundDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Logo and App Name
              _buildLogoSection(),
              const Spacer(flex: 1),
              // Tagline
              _buildTagline(),
              const Spacer(flex: 1),
              // Loading Animation
              _buildLoadingSection(),
              const Spacer(flex: 2),
              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        // Animated Logo
        AnimatedBuilder(
          animation: _logoAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _logoAnimation.value,
              child: Container(
                width: 120.w,
                height: 120.w,
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
                  size: AccessibilityTheme.getAccessibleIconSize(60),
                  color: AccessibilityTheme.isHighContrast
                      ? AppTheme.highContrastBackground
                      : AppTheme.backgroundDark,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 24.h),
        // App Name
        Text(
          'TrueScore',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.athletePrimary,
          ),
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildTagline() {
    return Column(
      children: [
        Text(
          'Unleashing Hidden Talent',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0),
        SizedBox(height: 8.h),
        Text(
          'AI-Powered Performance Tracking',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      children: [
        // Loading Bar
        Container(
          width: 200.w,
          height: 4.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.r),
            color: AppTheme.surfaceDark,
          ),
          child: AnimatedBuilder(
            animation: _loadingAnimation,
            builder: (context, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _loadingAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    gradient: AccessibilityTheme.isHighContrast
                        ? null
                        : AppTheme.athleteGradient,
                    color: AccessibilityTheme.isHighContrast
                        ? AppTheme.highContrastForeground
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        // Loading Text
        Text(
          'Loading...',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
          ),
        ).animate().fadeIn(delay: 1500.ms),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        // Version Info
        Text(
          'Version 1.0.0',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppTheme.textDisabled,
          ),
        ),
        SizedBox(height: 8.h),
        // Accessibility Info
        if (AccessibilityTheme.isHighContrast)
          Text(
            'High Contrast Mode',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: AppTheme.textDisabled,
            ),
          ),
        if (AccessibilityTheme.isLargeFont)
          Text(
            'Large Font Mode',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: AppTheme.textDisabled,
            ),
          ),
      ],
    );
  }
}

// Alternative splash screen with Lottie animation
class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      NavigationUtils.navigateToOnboarding(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.backgroundDark,
              AppTheme.primaryNavy,
              AppTheme.backgroundDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie Animation
              SizedBox(
                width: 200.w,
                height: 200.h,
                child: Lottie.asset(
                  'assets/animations/athlete_motion.json',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 32.h),
              // App Name
              Text(
                'TrueScore',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.athletePrimary,
                ),
              ),
              SizedBox(height: 8.h),
              // Tagline
              Text(
                'Unleashing Hidden Talent',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
