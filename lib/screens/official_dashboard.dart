import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../widgets/accessibility_toggle.dart';

class OfficialDashboard extends StatefulWidget {
  const OfficialDashboard({super.key});

  @override
  State<OfficialDashboard> createState() => _OfficialDashboardState();
}

class _OfficialDashboardState extends State<OfficialDashboard>
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
                  _buildSearchTab(),
                  _buildEventsTab(),
                  _buildShortlistTab(),
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
            : AppTheme.officialGradient,
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
                        AppTheme.officialSecondary,
                        AppTheme.officialAccent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: AccessibilityTheme.isHighContrast
                  ? AppTheme.highContrastForeground
                  : null,
            ),
            child: Icon(
              Icons.business,
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
                  'Coach Smith', // TODO: Get from user data
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
          // Stats
          _buildStats(),
        ],
      ),
    ).animate().slideY(begin: -0.3, end: 0, duration: 600.ms);
  }

  Widget _buildStats() {
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
                Icons.people,
                color: AccessibilityTheme.isHighContrast
                    ? AppTheme.highContrastForeground
                    : AppTheme.officialSecondary,
                size: AccessibilityTheme.getAccessibleIconSize(16),
              ),
              SizedBox(width: 4.w),
              Text(
                '24',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AccessibilityTheme.isHighContrast
                      ? AppTheme.highContrastForeground
                      : AppTheme.officialSecondary,
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
                Icons.star,
                color: AccessibilityTheme.isHighContrast
                    ? AppTheme.highContrastForeground
                    : AppTheme.officialAccent,
                size: AccessibilityTheme.getAccessibleIconSize(16),
              ),
              SizedBox(width: 4.w),
              Text(
                '8',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AccessibilityTheme.isHighContrast
                      ? AppTheme.highContrastForeground
                      : AppTheme.officialAccent,
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
              : AppTheme.officialGradient,
          color: AccessibilityTheme.isHighContrast
              ? AccessibilityTheme.getAccessibleColor(
                  AppTheme.officialSecondary,
                )
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
          Tab(icon: Icon(Icons.search), text: 'Search'),
          Tab(icon: Icon(Icons.event), text: 'Events'),
          Tab(icon: Icon(Icons.star), text: 'Shortlist'),
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
          // Quick Stats
          _buildQuickStats(),
          SizedBox(height: 24.h),
          // AI Suggestions
          _buildAISuggestions(),
          SizedBox(height: 24.h),
          // Recent Activity
          _buildRecentActivity(),
          SizedBox(height: 24.h),
          // Upcoming Events
          _buildUpcomingEvents(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: AccessibilityTheme.isHighContrast
            ? null
            : LinearGradient(
                colors: [
                  AppTheme.officialSecondary.withOpacity(0.1),
                  AppTheme.officialAccent.withOpacity(0.1),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.highContrastForeground,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Athletes Scouted',
                  '24',
                  Icons.people,
                  AppTheme.officialSecondary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  'Shortlisted',
                  '8',
                  Icons.star,
                  AppTheme.officialAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Evaluations',
                  '156',
                  Icons.assessment,
                  AppTheme.athletePrimary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  'Events',
                  '3',
                  Icons.event,
                  AppTheme.athleteSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AccessibilityTheme.getAccessibleColor(color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: AccessibilityTheme.isHighContrast
            ? Border.all(
                color: AccessibilityTheme.getAccessibleColor(color),
                width: 1,
              )
            : null,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AccessibilityTheme.getAccessibleColor(color),
            size: AccessibilityTheme.getAccessibleIconSize(20),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.highContrastForeground,
            ),
          ),
          Text(
            title,
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAISuggestions() {
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
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: AccessibilityTheme.getAccessibleColor(
                  AppTheme.athletePrimary,
                ),
                size: AccessibilityTheme.getAccessibleIconSize(20),
              ),
              SizedBox(width: 8.w),
              Text(
                'AI Suggestions',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.highContrastForeground,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Top 5 athletes for Basketball in Karnataka',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.highContrastForeground,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Based on your search criteria and recent activity',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to AI suggestions
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.athletePrimary,
              foregroundColor: AppTheme.backgroundDark,
              borderRadius: 8,
            ),
            child: Text(
              'View Suggestions',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.backgroundDark,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
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
              _buildActivityItem(
                'Evaluated Sarah Johnson',
                'Basketball - 4.5/5 rating',
                Icons.assessment,
                AppTheme.athletePrimary,
                '2 hours ago',
              ),
              SizedBox(height: 12.h),
              _buildActivityItem(
                'Shortlisted Mike Chen',
                'Swimming - Added to favorites',
                Icons.star,
                AppTheme.officialSecondary,
                '1 day ago',
              ),
              SizedBox(height: 12.h),
              _buildActivityItem(
                'Viewed 15 profiles',
                'Basketball category',
                Icons.visibility,
                AppTheme.athleteSecondary,
                '2 days ago',
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String time,
  ) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: AccessibilityTheme.getAccessibleColor(
              color,
            ).withOpacity(0.2),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            color: AccessibilityTheme.getAccessibleColor(color),
            size: AccessibilityTheme.getAccessibleIconSize(16),
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
        Text(
          time,
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
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
                'Basketball Championship',
                'Tomorrow, 2:00 PM',
                Icons.sports_basketball,
                AppTheme.athletePrimary,
              ),
              SizedBox(height: 12.h),
              _buildEventItem(
                'Talent Scouting Session',
                'Friday, 10:00 AM',
                Icons.search,
                AppTheme.officialSecondary,
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

  Widget _buildSearchTab() {
    return const Center(child: Text('Search Tab - Coming Soon'));
  }

  Widget _buildEventsTab() {
    return const Center(child: Text('Events Tab - Coming Soon'));
  }

  Widget _buildShortlistTab() {
    return const Center(child: Text('Shortlist Tab - Coming Soon'));
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
            : AccessibilityTheme.getAccessibleColor(AppTheme.officialSecondary),
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
          AppTheme.officialSecondary,
        ),
        unselectedItemColor: AppTheme.textSecondary,
        selectedLabelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AccessibilityTheme.getAccessibleColor(
            AppTheme.officialSecondary,
          ),
        ),
        unselectedLabelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppTheme.textSecondary,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Shortlist'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
