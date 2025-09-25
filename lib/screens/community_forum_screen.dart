import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';

class CommunityForumScreen extends StatefulWidget {
  const CommunityForumScreen({super.key});

  @override
  State<CommunityForumScreen> createState() => _CommunityForumScreenState();
}

class _CommunityForumScreenState extends State<CommunityForumScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Sample forum posts data
  final List<ForumPost> _recentPosts = [
    ForumPost(
      id: '1',
      username: 'Samy Mar 1022',
      userAvatar: '👨‍💼',
      content: 'Thir cem',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 5,
      replies: 2,
      isLiked: false,
    ),
    ForumPost(
      id: '2',
      username: 'Sarry Mort 2021',
      userAvatar: '👩‍💼',
      title: 'Tips for improving wheellall sprint?',
      content: 'Hoerde your proedideclalt sprint tilpn',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      likes: 12,
      replies: 8,
      isLiked: true,
    ),
    ForumPost(
      id: '3',
      username: 'Sumy Har 2013',
      userAvatar: '👨‍🎓',
      title: 'Tips for improving wheetiall sprires?',
      content: 'Nesuedinerting and cuptrest sprint',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      likes: 8,
      replies: 5,
      isLiked: false,
    ),
    ForumPost(
      id: '4',
      username: 'Harry Mont 1041',
      userAvatar: '👩‍🎓',
      title: 'Tips for improving wheellfall times?',
      content: 'Looking for advice on improving wheelchair racing times',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      likes: 15,
      replies: 12,
      isLiked: true,
    ),
  ];

  final List<ForumPost> _popularPosts = [
    ForumPost(
      id: '2',
      username: 'Sarry Mort 2021',
      userAvatar: '👩‍💼',
      title: 'Tips for improving wheellall sprint?',
      content: 'Hoerde your proedideclalt sprint tilpn',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      likes: 12,
      replies: 8,
      isLiked: true,
    ),
    ForumPost(
      id: '4',
      username: 'Harry Mont 1041',
      userAvatar: '👩‍🎓',
      title: 'Tips for improving wheellfall times?',
      content: 'Looking for advice on improving wheelchair racing times',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      likes: 15,
      replies: 12,
      isLiked: true,
    ),
    ForumPost(
      id: '3',
      username: 'Sumy Har 2013',
      userAvatar: '👨‍🎓',
      title: 'Tips for improving wheetiall sprires?',
      content: 'Nesuedinerting and cuptrest sprint',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      likes: 8,
      replies: 5,
      isLiked: false,
    ),
    ForumPost(
      id: '1',
      username: 'Samy Mar 1022',
      userAvatar: '👨‍💼',
      content: 'Thir cem',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 5,
      replies: 2,
      isLiked: false,
    ),
  ];

  final List<ForumPost> _myPosts = [
    ForumPost(
      id: '5',
      username: 'You',
      userAvatar: '👤',
      title: 'My training progress',
      content: 'Just completed my first 5K race!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      likes: 3,
      replies: 1,
      isLiked: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            SizedBox(height: 16.h),

            // Page Title
            _buildPageTitle(),
            SizedBox(height: 24.h),

            // Navigation Tabs
            _buildNavigationTabs(),
            SizedBox(height: 16.h),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostsList(_recentPosts),
                  _buildPostsList(_popularPosts),
                  _buildPostsList(_myPosts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Adaptive Sports Hub Logo
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.highContrastForeground,
                ),
                child: Center(
                  child: Text(
                    'A',
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.backgroundDark,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Adaptive Sports Hub',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.highContrastForeground,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Create Post Button
          GestureDetector(
            onTap: _showCreatePostDialog,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(20.r),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    color: AppTheme.highContrastForeground,
                    size: AccessibilityTheme.getAccessibleIconSize(16),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Create Post',
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.highContrastForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: -0.3, end: 0, duration: 600.ms);
  }

  Widget _buildPageTitle() {
    return Center(
      child: Text(
        'Community Forum',
        style: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppTheme.highContrastForeground,
        ),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildNavigationTabs() {
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
          color: AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary),
        ),
        labelColor: AppTheme.backgroundDark,
        unselectedLabelColor: AppTheme.textSecondary,
        labelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.backgroundDark,
        ),
        unselectedLabelStyle: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppTheme.textSecondary,
        ),
        tabs: const [
          Tab(text: 'Recent Posts'),
          Tab(text: 'Popular'),
          Tab(text: 'My Posts'),
        ],
      ),
    ).animate().slideY(begin: 0.3, end: 0, delay: 400.ms);
  }

  Widget _buildPostsList(List<ForumPost> posts) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(posts[index])
            .animate()
            .fadeIn(delay: Duration(milliseconds: 200 + (index * 100)))
            .slideY(begin: 0.3, end: 0);
      },
    );
  }

  Widget _buildPostCard(ForumPost post) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
          // User Info Row
          Row(
            children: [
              // User Avatar
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.athletePrimary.withOpacity(0.2),
                ),
                child: Center(
                  child: Text(
                    post.userAvatar,
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.highContrastForeground,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Username
              Expanded(
                child: Text(
                  post.username,
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.highContrastForeground,
                  ),
                ),
              ),

              // More Options
              GestureDetector(
                onTap: () => _showPostOptions(post),
                child: Icon(
                  Icons.more_vert,
                  color: AppTheme.textSecondary,
                  size: AccessibilityTheme.getAccessibleIconSize(20),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Post Title (if exists)
          if (post.title != null) ...[
            Text(
              post.title!,
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.highContrastForeground,
              ),
            ),
            SizedBox(height: 8.h),
          ],

          // Post Content
          Text(
            post.content,
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppTheme.highContrastForeground,
            ),
          ),

          SizedBox(height: 16.h),

          // Interaction Buttons
          Row(
            children: [
              // Like Button
              _buildInteractionButton(
                icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                label: '${post.likes}',
                isActive: post.isLiked,
                onTap: () => _toggleLike(post),
              ),
              SizedBox(width: 16.w),

              // Reply Button
              _buildInteractionButton(
                icon: Icons.reply,
                label: 'Reply',
                onTap: () => _showReplyDialog(post),
              ),
              SizedBox(width: 16.w),

              // Thumbs Up
              _buildInteractionButton(
                icon: Icons.thumb_up_outlined,
                label: '',
                onTap: () => _thumbsUp(post),
              ),
              SizedBox(width: 8.w),

              // Thumbs Down
              _buildInteractionButton(
                icon: Icons.thumb_down_outlined,
                label: '',
                onTap: () => _thumbsDown(post),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isActive
              ? AccessibilityTheme.getAccessibleColor(
                  AppTheme.athletePrimary,
                ).withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? AccessibilityTheme.getAccessibleColor(
                      AppTheme.athletePrimary,
                    )
                  : AppTheme.textSecondary,
              size: AccessibilityTheme.getAccessibleIconSize(16),
            ),
            if (label.isNotEmpty) ...[
              SizedBox(width: 4.w),
              Text(
                label,
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: isActive
                      ? AccessibilityTheme.getAccessibleColor(
                          AppTheme.athletePrimary,
                        )
                      : AppTheme.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppTheme.backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Center(
                child: Text(
                  'Create a New Post',
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.highContrastForeground,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Title Input Field
              Text(
                'Title',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.highContrastForeground,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  hintText: 'e.g. How to improve my diet?',
                  hintStyle: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppTheme.textSecondary,
                  ),
                  filled: true,
                  fillColor: AppTheme.highContrastForeground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.backgroundDark,
                ),
              ),
              SizedBox(height: 16.h),

              // Content Input Field
              TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  hintStyle: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppTheme.textSecondary,
                  ),
                  filled: true,
                  fillColor: AppTheme.highContrastForeground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.backgroundDark,
                ),
              ),
              SizedBox(height: 24.h),

              // Post Button
              Container(
                width: double.infinity,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AccessibilityTheme.getAccessibleColor(
                    AppTheme.athletePrimary,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      Navigator.pop(context);
                      _showSuccessSnackBar('Post created successfully!');
                    },
                    child: Center(
                      child: Text(
                        'Post',
                        style: AccessibilityTheme.createAccessibleTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.backgroundDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReplyDialog(ForumPost post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Reply to ${post.username}',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        content: TextField(
          maxLines: 3,
          decoration: AccessibilityTheme.createAccessibleInputDecoration(
            labelText: 'Your reply',
            hintText: 'Write your reply...',
          ),
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
              _showSuccessSnackBar('Reply posted successfully!');
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.athletePrimary,
              foregroundColor: AppTheme.backgroundDark,
            ),
            child: Text(
              'Reply',
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

  void _showPostOptions(ForumPost post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.share,
                color: AppTheme.highContrastForeground,
              ),
              title: Text(
                'Share',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.highContrastForeground,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showSuccessSnackBar('Post shared!');
              },
            ),
            if (post.username == 'You') ...[
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: AppTheme.highContrastForeground,
                ),
                title: Text(
                  'Edit',
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppTheme.highContrastForeground,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showSuccessSnackBar('Edit functionality coming soon!');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: AppTheme.error),
                title: Text(
                  'Delete',
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppTheme.error,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showSuccessSnackBar('Post deleted!');
                },
              ),
            ],
            ListTile(
              leading: Icon(Icons.report, color: AppTheme.error),
              title: Text(
                'Report',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.error,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showSuccessSnackBar('Post reported!');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLike(ForumPost post) {
    setState(() {
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
    });
  }

  void _thumbsUp(ForumPost post) {
    _showSuccessSnackBar('Thumbs up!');
  }

  void _thumbsDown(ForumPost post) {
    _showSuccessSnackBar('Thumbs down!');
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

class ForumPost {
  final String id;
  final String username;
  final String userAvatar;
  final String? title;
  final String content;
  final DateTime timestamp;
  int likes;
  final int replies;
  bool isLiked;

  ForumPost({
    required this.id,
    required this.username,
    required this.userAvatar,
    this.title,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.replies,
    required this.isLiked,
  });
}
