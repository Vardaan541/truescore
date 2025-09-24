import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../widgets/accessibility_toggle.dart';

class AthleteDashboard extends StatefulWidget {
  const AthleteDashboard({super.key});

  @override
  State<AthleteDashboard> createState() => _AthleteDashboardState();
}

class _AthleteDashboardState extends State<AthleteDashboard>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Tab Bar
            _buildTabBar(),
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHomeTab(),
                  _buildTestsTab(),
                  _buildPortfolioTab(),
                  _buildCommunityTab(),
                  _buildSettingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: AccessibilityTheme.isHighContrast
            ? null
            : AppTheme.holographicGradient,
        color: AccessibilityTheme.isHighContrast ? AppTheme.surfaceDark : null,
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
          // Profile Picture
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AccessibilityTheme.isHighContrast
                  ? null
                  : LinearGradient(
                      colors: [
                        AppTheme.athletePrimary,
                        AppTheme.athleteSecondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: AccessibilityTheme.isHighContrast
                  ? AppTheme.highContrastForeground
                  : null,
            ),
            child: Icon(
              Icons.person,
              color: AccessibilityTheme.isHighContrast
                  ? AppTheme.highContrastBackground
                  : AppTheme.backgroundDark,
              size: AccessibilityTheme.getAccessibleIconSize(24),
            ),
          ),
          SizedBox(width: 12.w),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AccessibilityTheme.isHighContrast
                        ? AppTheme.highContrastBackground
                        : AppTheme.backgroundDark,
                  ),
                ),
                Text(
                  'John Doe', // TODO: Get from user data
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AccessibilityTheme.isHighContrast
                        ? AppTheme.highContrastBackground
                        : AppTheme.backgroundDark,
                  ),
                ),
              ],
            ),
          ),
          // Points and Badges
          _buildPointsBadges(),
        ],
      ),
    ).animate().slideY(begin: -0.3, end: 0, duration: 600.ms);
  }

  Widget _buildPointsBadges() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AccessibilityTheme.isHighContrast
                ? AppTheme.highContrastBackground
                : AppTheme.backgroundDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: AccessibilityTheme.isHighContrast
                    ? AppTheme.highContrastForeground
                    : AppTheme.athletePrimary,
                size: AccessibilityTheme.getAccessibleIconSize(16),
              ),
              SizedBox(width: 4.w),
              Text(
                '1,250',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AccessibilityTheme.isHighContrast
                      ? AppTheme.highContrastForeground
                      : AppTheme.athletePrimary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AccessibilityTheme.isHighContrast
                ? AppTheme.highContrastBackground
                : AppTheme.backgroundDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events,
                color: AccessibilityTheme.isHighContrast
                    ? AppTheme.highContrastForeground
                    : AppTheme.athleteAccent,
                size: AccessibilityTheme.getAccessibleIconSize(16),
              ),
              SizedBox(width: 4.w),
              Text(
                '5',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AccessibilityTheme.isHighContrast
                      ? AppTheme.highContrastForeground
                      : AppTheme.athleteAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: AccessibilityTheme.isHighContrast
              ? null
              : AppTheme.athleteGradient,
          color: AccessibilityTheme.isHighContrast
              ? AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary)
              : null,
        ),
        labelColor: AccessibilityTheme.isHighContrast
            ? AppTheme.highContrastBackground
            : AppTheme.backgroundDark,
        unselectedLabelColor: AppTheme.textSecondary,
        labelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AccessibilityTheme.isHighContrast
              ? AppTheme.highContrastBackground
              : AppTheme.backgroundDark,
        ),
        unselectedLabelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppTheme.textSecondary,
        ),
        tabs: const [
          Tab(icon: Icon(Icons.home), text: 'Home'),
          Tab(icon: Icon(Icons.track_changes), text: 'Tests'),
          Tab(icon: Icon(Icons.person), text: 'Portfolio'),
          Tab(icon: Icon(Icons.group), text: 'Community'),
          Tab(icon: Icon(Icons.settings), text: 'Settings'),
        ],
      ),
    ).animate().slideY(begin: 0.3, end: 0, delay: 200.ms);
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Motivational Quote
          _buildMotivationalQuote(),
          SizedBox(height: 24.h),
          // Main Action Tiles
          _buildMainActionTiles(),
          SizedBox(height: 24.h),
          // Progress Section
          _buildProgressSection(),
          SizedBox(height: 24.h),
          // Upcoming Events
          _buildUpcomingEvents(),
        ],
      ),
    );
  }

  Widget _buildMotivationalQuote() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: AccessibilityTheme.isHighContrast
            ? null
            : LinearGradient(
                colors: [
                  AppTheme.athletePrimary.withOpacity(0.1),
                  AppTheme.athleteSecondary.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        color: AccessibilityTheme.isHighContrast ? AppTheme.surfaceDark : null,
        borderRadius: BorderRadius.circular(16.r),
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
          Icon(
            Icons.format_quote,
            color: AccessibilityTheme.getAccessibleColor(
              AppTheme.athletePrimary,
            ),
            size: AccessibilityTheme.getAccessibleIconSize(32),
          ),
          SizedBox(height: 12.h),
          Text(
            '"Every champion was once a contender who refused to give up."',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.highContrastForeground,
              lineHeight: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Today\'s Motivation',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildMainActionTiles() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                icon: Icons.play_arrow,
                title: 'Start Test',
                subtitle: 'Begin a new performance test',
                color: AppTheme.athletePrimary,
                onTap: () {
                  // TODO: Navigate to test selection
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildActionTile(
                icon: Icons.analytics,
                title: 'My Progress',
                subtitle: 'View your performance trends',
                color: AppTheme.athleteSecondary,
                onTap: () {
                  // TODO: Navigate to progress page
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                icon: Icons.emoji_events,
                title: 'Achievements',
                subtitle: 'View your badges and milestones',
                color: AppTheme.athleteAccent,
                onTap: () {
                  // TODO: Navigate to achievements page
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildActionTile(
                icon: Icons.person,
                title: 'Portfolio',
                subtitle: 'Manage your profile',
                color: AppTheme.primaryGold,
                onTap: () {
                  _tabController.animateTo(2);
                },
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          boxShadow: [
            BoxShadow(
              color: AccessibilityTheme.getAccessibleColor(
                color,
              ).withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AccessibilityTheme.getAccessibleColor(color),
              size: AccessibilityTheme.getAccessibleIconSize(24),
            ),
            SizedBox(height: 8.h),
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
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
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
          child: Column(
            children: [
              _buildProgressItem('Strength', 0.8, AppTheme.athletePrimary),
              SizedBox(height: 12.h),
              _buildProgressItem('Agility', 0.6, AppTheme.athleteSecondary),
              SizedBox(height: 12.h),
              _buildProgressItem('Stamina', 0.7, AppTheme.athleteAccent),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildProgressItem(String label, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.highContrastForeground,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppTheme.textSecondary.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(
            AccessibilityTheme.getAccessibleColor(color),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Events',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
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
          child: Column(
            children: [
              _buildEventItem(
                'Basketball Training',
                'Tomorrow, 6:00 PM',
                Icons.sports_basketball,
                AppTheme.athletePrimary,
              ),
              SizedBox(height: 12.h),
              _buildEventItem(
                'Performance Test',
                'Friday, 10:00 AM',
                Icons.track_changes,
                AppTheme.athleteSecondary,
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildEventItem(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AccessibilityTheme.getAccessibleColor(
              color,
            ).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: AccessibilityTheme.getAccessibleColor(color),
            size: AccessibilityTheme.getAccessibleIconSize(20),
          ),
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
                time,
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
    );
  }

  Widget _buildTestsTab() {
    return const Center(child: Text('Tests Tab - Coming Soon'));
  }

  Widget _buildPortfolioTab() {
    return const Center(child: Text('Portfolio Tab - Coming Soon'));
  }

  Widget _buildCommunityTab() {
    return const Center(child: Text('Community Tab - Coming Soon'));
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Accessibility Toggle
          const AccessibilityToggle(),
          SizedBox(height: 24.h),
          // Other Settings
          _buildSettingsSection(),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Settings',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.highContrastForeground,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSettingItem(
            icon: Icons.person,
            title: 'Edit Profile',
            subtitle: 'Update your personal information',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage your notification preferences',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip,
            title: 'Privacy',
            subtitle: 'Control your privacy settings',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.logout,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            onTap: () {},
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? AppTheme.error
            : AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary),
        size: AccessibilityTheme.getAccessibleIconSize(20),
      ),
      title: Text(
        title,
        style: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDestructive
              ? AppTheme.error
              : AppTheme.highContrastForeground,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppTheme.textSecondary,
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

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: AccessibilityTheme.isHighContrast
            ? Border(
                top: BorderSide(
                  color: AccessibilityTheme.getAccessibleColor(
                    AppTheme.textSecondary,
                  ),
                  width: 1,
                ),
              )
            : null,
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _tabController.animateTo(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.surfaceDark,
        selectedItemColor: AccessibilityTheme.getAccessibleColor(
          AppTheme.athletePrimary,
        ),
        unselectedItemColor: AppTheme.textSecondary,
        selectedLabelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary),
        ),
        unselectedLabelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppTheme.textSecondary,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Tests',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Portfolio'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
