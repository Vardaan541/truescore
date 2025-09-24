import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../utils/navigation_utils.dart';
import '../models/official.dart';

class OfficialSignupScreen extends StatefulWidget {
  const OfficialSignupScreen({super.key});

  @override
  State<OfficialSignupScreen> createState() => _OfficialSignupScreenState();
}

class _OfficialSignupScreenState extends State<OfficialSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _organizationController = TextEditingController();
  final _bioController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  int _currentStep = 0;

  // Official information
  OfficialType _officialType = OfficialType.coach;
  List<String> _specializations = [];
  List<String> _certifications = [];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _organizationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    setState(() {
      _currentStep--;
    });
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate signup process
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        NavigationUtils.navigateToOfficialDashboard(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundDark,
        foregroundColor: AppTheme.highContrastForeground,
        elevation: 0,
        title: Text(
          'Sign Up - Official',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.highContrastForeground,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.highContrastForeground,
            size: AccessibilityTheme.getAccessibleIconSize(24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress Indicator
                _buildProgressIndicator(),
                SizedBox(height: 32.h),
                // Step Content
                _buildStepContent(),
                SizedBox(height: 32.h),
                // Navigation Buttons
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / 3,
                backgroundColor: AppTheme.surfaceDark,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AccessibilityTheme.getAccessibleColor(
                    AppTheme.officialSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Step ${_currentStep + 1} of 3',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildOfficialInfoStep();
      case 2:
        return _buildProfessionalInfoStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Basic Information',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.officialSecondary,
          ),
        ).animate().fadeIn(delay: 200.ms),
        SizedBox(height: 24.h),
        // Name Field
        TextFormField(
          controller: _nameController,
          decoration: AccessibilityTheme.createAccessibleInputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            borderColor: AppTheme.textSecondary,
            focusedBorderColor: AppTheme.officialSecondary,
          ),
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ).animate().slideX(begin: -0.3, end: 0, delay: 400.ms),
        SizedBox(height: 16.h),
        // Email Field
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: AccessibilityTheme.createAccessibleInputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            borderColor: AppTheme.textSecondary,
            focusedBorderColor: AppTheme.officialSecondary,
          ),
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ).animate().slideX(begin: -0.3, end: 0, delay: 600.ms),
        SizedBox(height: 16.h),
        // Password Field
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration:
              AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                borderColor: AppTheme.textSecondary,
                focusedBorderColor: AppTheme.officialSecondary,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: AppTheme.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ).animate().slideX(begin: -0.3, end: 0, delay: 800.ms),
        SizedBox(height: 16.h),
        // Confirm Password Field
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration:
              AccessibilityTheme.createAccessibleInputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm your password',
                borderColor: AppTheme.textSecondary,
                focusedBorderColor: AppTheme.officialSecondary,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppTheme.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ).animate().slideX(begin: -0.3, end: 0, delay: 1000.ms),
      ],
    );
  }

  Widget _buildOfficialInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Official Information',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.officialSecondary,
          ),
        ).animate().fadeIn(delay: 200.ms),
        SizedBox(height: 24.h),
        // Official Type
        _buildOfficialTypeSelector(),
        SizedBox(height: 16.h),
        // Organization
        TextFormField(
          controller: _organizationController,
          decoration: AccessibilityTheme.createAccessibleInputDecoration(
            labelText: 'Organization',
            hintText: 'Enter your organization name',
            borderColor: AppTheme.textSecondary,
            focusedBorderColor: AppTheme.officialSecondary,
          ),
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your organization';
            }
            return null;
          },
        ).animate().slideY(begin: 0.3, end: 0, delay: 600.ms),
        SizedBox(height: 16.h),
        // Bio
        TextFormField(
          controller: _bioController,
          decoration: AccessibilityTheme.createAccessibleInputDecoration(
            labelText: 'Bio (Optional)',
            hintText: 'Tell us about yourself and your experience',
            borderColor: AppTheme.textSecondary,
            focusedBorderColor: AppTheme.officialSecondary,
          ),
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
          maxLines: 4,
        ).animate().slideY(begin: 0.3, end: 0, delay: 800.ms),
      ],
    );
  }

  Widget _buildOfficialTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What type of official are you?',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 12.h),
        ...OfficialType.values.map((type) {
          return RadioListTile<OfficialType>(
            title: Text(
              _getOfficialTypeLabel(type),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            value: type,
            groupValue: _officialType,
            onChanged: (value) {
              setState(() {
                _officialType = value!;
              });
            },
            activeColor: AccessibilityTheme.getAccessibleColor(
              AppTheme.officialSecondary,
            ),
          );
        }).toList(),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 400.ms);
  }

  String _getOfficialTypeLabel(OfficialType type) {
    switch (type) {
      case OfficialType.coach:
        return 'Coach';
      case OfficialType.judge:
        return 'Judge';
      case OfficialType.recruiter:
        return 'Recruiter';
      case OfficialType.scout:
        return 'Scout';
    }
  }

  Widget _buildProfessionalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Professional Information',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.officialSecondary,
          ),
        ).animate().fadeIn(delay: 200.ms),
        SizedBox(height: 24.h),
        // Specializations
        _buildSpecializationsSelector(),
        SizedBox(height: 24.h),
        // Certifications
        _buildCertificationsSelector(),
      ],
    );
  }

  Widget _buildSpecializationsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specializations (Select all that apply):',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              [
                'Basketball',
                'Football',
                'Tennis',
                'Swimming',
                'Athletics',
                'Cycling',
                'Wheelchair Sports',
                'Para Sports',
                'General Fitness',
                'Sports Psychology',
              ].map((specialization) {
                final isSelected = _specializations.contains(specialization);
                return FilterChip(
                  label: Text(
                    specialization,
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isSelected
                          ? AppTheme.backgroundDark
                          : AppTheme.highContrastForeground,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _specializations.add(specialization);
                      } else {
                        _specializations.remove(specialization);
                      }
                    });
                  },
                  selectedColor: AccessibilityTheme.getAccessibleColor(
                    AppTheme.officialSecondary,
                  ),
                  checkmarkColor: AppTheme.backgroundDark,
                );
              }).toList(),
        ),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 400.ms);
  }

  Widget _buildCertificationsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certifications (Select all that apply):',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              [
                'Coaching License',
                'Referee Certification',
                'Sports Medicine',
                'Physical Therapy',
                'Sports Psychology',
                'Nutrition',
                'Strength & Conditioning',
                'Para Sports Certification',
                'Youth Sports',
                'Professional League',
              ].map((certification) {
                final isSelected = _certifications.contains(certification);
                return FilterChip(
                  label: Text(
                    certification,
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isSelected
                          ? AppTheme.backgroundDark
                          : AppTheme.highContrastForeground,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _certifications.add(certification);
                      } else {
                        _certifications.remove(certification);
                      }
                    });
                  },
                  selectedColor: AccessibilityTheme.getAccessibleColor(
                    AppTheme.officialSecondary,
                  ),
                  checkmarkColor: AppTheme.backgroundDark,
                );
              }).toList(),
        ),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 600.ms);
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (_currentStep > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: _previousStep,
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
        if (_currentStep > 0) SizedBox(width: 16.w),
        Expanded(
          flex: _currentStep > 0 ? 1 : 2,
          child: ElevatedButton(
            onPressed: _currentStep == 2 ? _handleSignup : _nextStep,
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: AppTheme.officialSecondary,
              foregroundColor: AppTheme.backgroundDark,
              borderRadius: 12,
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.backgroundDark,
                      ),
                    ),
                  )
                : Text(
                    _currentStep == 2 ? 'Create Account' : 'Next',
                    style: AccessibilityTheme.createAccessibleTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.backgroundDark,
                    ),
                  ),
          ),
        ),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 1400.ms);
  }
}
