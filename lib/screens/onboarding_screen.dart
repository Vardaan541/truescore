import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../utils/navigation_utils.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingData> _onboardingPages = [
    OnboardingData(
      title: 'Discover Talent',
      description:
          'AI-assisted performance tracking that helps you understand your strengths and areas for improvement.',
      icon: Icons.auto_awesome,
      color: AppTheme.athletePrimary,
    ),
    OnboardingData(
      title: 'Inclusive for All',
      description:
          'Disability-aware design ensures every athlete can participate and showcase their abilities.',
      icon: Icons.accessibility_new,
      color: AppTheme.athleteSecondary,
    ),
    OnboardingData(
      title: 'Get Recognized',
      description:
          'Build your profile, connect with scouts, and get discovered by the right people.',
      icon: Icons.visibility,
      color: AppTheme.athleteAccent,
    ),
    OnboardingData(
      title: 'Stay Motivated',
      description:
          'Earn badges, complete challenges, and track your progress with gamified features.',
      icon: Icons.emoji_events,
      color: AppTheme.primaryGold,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: AppTheme.mediumAnimation,
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: AppTheme.mediumAnimation,
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() {
    NavigationUtils.navigateToLogin(context);
  }

  void _skipOnboarding() {
    NavigationUtils.navigateToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            _buildSkipButton(),
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: _onboardingPages[index],
                    isLastPage: index == _onboardingPages.length - 1,
                    onNext: _nextPage,
                    onSkip: _skipOnboarding,
                  );
                },
              ),
            ),
            // Page Indicators and Navigation
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _skipOnboarding,
            child: Text(
              'Skip',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Page Indicators
          _buildPageIndicators(),
          SizedBox(height: 24.h),
          // Navigation Buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingPages.length,
        (index) => _buildPageIndicator(index),
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    final isActive = index == _currentPage;
    return AnimatedContainer(
      duration: AppTheme.shortAnimation,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: isActive
            ? AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary)
            : AccessibilityTheme.getAccessibleColor(AppTheme.textDisabled),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        // Previous Button
        if (_currentPage > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: _previousPage,
              style: AccessibilityTheme.createAccessibleButtonStyle(
                backgroundColor: Colors.transparent,
                foregroundColor: AppTheme.textSecondary,
                borderRadius: 12,
              ),
              child: Text(
                'Previous',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),
        if (_currentPage > 0) SizedBox(width: 16.w),
        // Next/Get Started Button
        Expanded(
          flex: _currentPage > 0 ? 1 : 2,
          child: ElevatedButton(
            onPressed: _nextPage,
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.athletePrimary,
              foregroundColor: AppTheme.backgroundDark,
              borderRadius: 12,
            ),
            child: Text(
              _currentPage == _onboardingPages.length - 1
                  ? 'Get Started'
                  : 'Next',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.backgroundDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
