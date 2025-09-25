import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  bool _isVideoPlaying = false;

  // Test instructions data
  final List<TestInstruction> _instructions = [
    TestInstruction(
      icon: Icons.pan_tool,
      text: 'Position hands wider than shoulder-width apart',
    ),
    TestInstruction(
      icon: Icons.straighten,
      text: 'Keep your body in a straight line from head to heels',
    ),
    TestInstruction(
      icon: Icons.straighten,
      text: 'Keep your body from head to heels',
    ),
    TestInstruction(
      icon: Icons.keyboard_arrow_down,
      text: 'Lower your chest towards the floor',
    ),
    TestInstruction(
      icon: Icons.keyboard_arrow_down,
      text: 'Lower your chest towards the floor',
    ),
    TestInstruction(
      icon: Icons.circle,
      text: 'Push back up to starting position',
    ),
    TestInstruction(icon: Icons.warning, text: 'Stop if you feel any pain'),
    TestInstruction(
      icon: Icons.medical_services,
      text: 'Consult a healthcare professional if you have concerns',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              _buildTitle(),
              SizedBox(height: 24.h),

              // Video Player Placeholder
              _buildVideoPlayer(),
              SizedBox(height: 24.h),

              // Instructions List
              _buildInstructionsList(),
              SizedBox(height: 32.h),

              // Start Test Button
              _buildStartTestButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        'Push-up Test: Instructions',
        style: AccessibilityTheme.createAccessibleTextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppTheme.highContrastForeground,
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.3, end: 0);
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Video placeholder background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_filled,
                    color: AccessibilityTheme.getAccessibleColor(
                      AppTheme.athletePrimary,
                    ),
                    size: AccessibilityTheme.getAccessibleIconSize(64),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Tap to play video',
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Play button overlay
          if (!_isVideoPlaying)
            GestureDetector(
              onTap: _playVideo,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AccessibilityTheme.getAccessibleColor(
                        AppTheme.athletePrimary,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AccessibilityTheme.getAccessibleColor(
                            AppTheme.athletePrimary,
                          ).withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: AppTheme.backgroundDark,
                      size: AccessibilityTheme.getAccessibleIconSize(40),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildInstructionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 16.h),
        ..._instructions.asMap().entries.map((entry) {
          int index = entry.key;
          TestInstruction instruction = entry.value;
          return _buildInstructionItem(instruction, index);
        }).toList(),
      ],
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildInstructionItem(TestInstruction instruction, int index) {
    return Container(
          margin: EdgeInsets.only(bottom: 12.h),
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
              // Instruction Icon
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AccessibilityTheme.getAccessibleColor(
                    AppTheme.athletePrimary,
                  ).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  instruction.icon,
                  color: AccessibilityTheme.getAccessibleColor(
                    AppTheme.athletePrimary,
                  ),
                  size: AccessibilityTheme.getAccessibleIconSize(20),
                ),
              ),
              SizedBox(width: 16.w),

              // Instruction Text
              Expanded(
                child: Text(
                  instruction.text,
                  style: AccessibilityTheme.createAccessibleTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppTheme.highContrastForeground,
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 800 + (index * 100)))
        .slideX(begin: -0.3, end: 0);
  }

  Widget _buildStartTestButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: AccessibilityTheme.isHighContrast
            ? null
            : LinearGradient(
                colors: [
                  AccessibilityTheme.getAccessibleColor(
                    AppTheme.athletePrimary,
                  ),
                  AccessibilityTheme.getAccessibleColor(
                    AppTheme.athleteSecondary,
                  ),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        color: AccessibilityTheme.isHighContrast
            ? AccessibilityTheme.getAccessibleColor(AppTheme.athletePrimary)
            : null,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AccessibilityTheme.getAccessibleColor(
              AppTheme.athletePrimary,
            ).withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: _startTest,
          child: Center(
            child: Text(
              'START TEST',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.backgroundDark,
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.3, end: 0);
  }

  void _playVideo() {
    setState(() {
      _isVideoPlaying = true;
    });

    // Simulate video playing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVideoPlaying = false;
        });
        _showSuccessSnackBar('Video playback completed');
      }
    });

    _showSuccessSnackBar('Video started playing');
  }

  void _startTest() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Start Push-up Test',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you ready to begin the push-up test?',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.athletePrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AccessibilityTheme.getAccessibleColor(
                    AppTheme.athletePrimary,
                  ),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AccessibilityTheme.getAccessibleColor(
                      AppTheme.athletePrimary,
                    ),
                    size: AccessibilityTheme.getAccessibleIconSize(20),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Make sure you have enough space and are ready to perform push-ups safely.',
                      style: AccessibilityTheme.createAccessibleTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppTheme.highContrastForeground,
                      ),
                    ),
                  ),
                ],
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
              _beginTest();
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.athletePrimary,
              foregroundColor: AppTheme.backgroundDark,
            ),
            child: Text(
              'Begin Test',
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

  void _beginTest() {
    _showSuccessSnackBar('Push-up test started! Good luck!');

    // Navigate to test execution screen
    Future.delayed(const Duration(seconds: 1), () {
      _showTestExecutionScreen();
    });
  }

  void _showTestExecutionScreen() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Test in Progress',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AccessibilityTheme.getAccessibleColor(
                  AppTheme.athletePrimary,
                ).withOpacity(0.2),
              ),
              child: Icon(
                Icons.fitness_center,
                color: AccessibilityTheme.getAccessibleColor(
                  AppTheme.athletePrimary,
                ),
                size: AccessibilityTheme.getAccessibleIconSize(40),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Perform as many push-ups as you can in 60 seconds.',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              'Time: 60 seconds',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AccessibilityTheme.getAccessibleColor(
                  AppTheme.athletePrimary,
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showTestResults();
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.success,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Complete Test',
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

  void _showTestResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Test Results',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.highContrastForeground,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppTheme.success, width: 1),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: AppTheme.success,
                    size: AccessibilityTheme.getAccessibleIconSize(32),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Great job!',
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Push-ups completed: 25',
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.highContrastForeground,
                    ),
                  ),
                  Text(
                    'Time: 60 seconds',
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
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
              _showSuccessSnackBar('Test results saved!');
            },
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.athletePrimary,
              foregroundColor: AppTheme.backgroundDark,
            ),
            child: Text(
              'Save Results',
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

class TestInstruction {
  final IconData icon;
  final String text;

  TestInstruction({required this.icon, required this.text});
}
