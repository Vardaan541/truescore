import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../utils/navigation_utils.dart';
import '../models/user.dart';
import '../models/athlete.dart';

class AthleteSignupScreen extends StatefulWidget {
  final UserRole role;

  const AthleteSignupScreen({super.key, required this.role});

  @override
  State<AthleteSignupScreen> createState() => _AthleteSignupScreenState();
}

class _AthleteSignupScreenState extends State<AthleteSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  int _currentStep = 0;

  // Disability information
  DisabilityType _disabilityType = DisabilityType.none;
  String? _disabilityDescription;
  int? _yearOfOnset;
  bool _hasParaSportClassification = false;
  String? _paraSportOrganization;

  // Sport information
  List<SportType> _selectedSports = [];
  ParticipationLevel _participationLevel = ParticipationLevel.beginner;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
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
        NavigationUtils.navigateToAthleteDashboard(context);
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
          'Sign Up - ${widget.role == UserRole.athlete ? 'Athlete' : 'Para-Athlete'}',
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
                    AppTheme.athletePrimary,
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
        return _buildDisabilityInfoStep();
      case 2:
        return _buildSportInfoStep();
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
            color: AppTheme.athletePrimary,
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
            focusedBorderColor: AppTheme.athletePrimary,
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
            focusedBorderColor: AppTheme.athletePrimary,
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
        // Phone Field
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: AccessibilityTheme.createAccessibleInputDecoration(
            labelText: 'Phone Number (Optional)',
            hintText: 'Enter your phone number',
            borderColor: AppTheme.textSecondary,
            focusedBorderColor: AppTheme.athletePrimary,
          ),
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.highContrastForeground,
          ),
        ).animate().slideX(begin: -0.3, end: 0, delay: 800.ms),
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
                focusedBorderColor: AppTheme.athletePrimary,
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
        ).animate().slideX(begin: -0.3, end: 0, delay: 1000.ms),
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
                focusedBorderColor: AppTheme.athletePrimary,
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
        ).animate().slideX(begin: -0.3, end: 0, delay: 1200.ms),
      ],
    );
  }

  Widget _buildDisabilityInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Disability Information',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.athletePrimary,
          ),
        ).animate().fadeIn(delay: 200.ms),
        SizedBox(height: 8.h),
        Text(
          'This information helps us provide better support and recommendations.',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
          ),
        ).animate().fadeIn(delay: 400.ms),
        SizedBox(height: 24.h),
        // Disability Type
        _buildDisabilityTypeSelector(),
        SizedBox(height: 16.h),
        // Disability Description
        if (_disabilityType != DisabilityType.none)
          TextFormField(
            controller: TextEditingController(
              text: _disabilityDescription ?? '',
            ),
            decoration: AccessibilityTheme.createAccessibleInputDecoration(
              labelText: 'Disability Description (Optional)',
              hintText: 'Describe your disability',
              borderColor: AppTheme.textSecondary,
              focusedBorderColor: AppTheme.athletePrimary,
            ),
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppTheme.highContrastForeground,
            ),
            onChanged: (value) {
              _disabilityDescription = value;
            },
            maxLines: 3,
          ).animate().slideY(begin: 0.3, end: 0, delay: 600.ms),
        SizedBox(height: 16.h),
        // Year of Onset
        if (_disabilityType != DisabilityType.none)
          TextFormField(
            controller: TextEditingController(
              text: _yearOfOnset?.toString() ?? '',
            ),
            keyboardType: TextInputType.number,
            decoration: AccessibilityTheme.createAccessibleInputDecoration(
              labelText: 'Year of Onset (Optional)',
              hintText: 'e.g., 2010',
              borderColor: AppTheme.textSecondary,
              focusedBorderColor: AppTheme.athletePrimary,
            ),
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppTheme.highContrastForeground,
            ),
            onChanged: (value) {
              _yearOfOnset = int.tryParse(value);
            },
          ).animate().slideY(begin: 0.3, end: 0, delay: 800.ms),
        SizedBox(height: 16.h),
        // Para-sport Classification
        _buildParaSportClassification(),
      ],
    );
  }

  Widget _buildDisabilityTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you have a physical disability?',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 12.h),
        ...DisabilityType.values.map((type) {
          return RadioListTile<DisabilityType>(
            title: Text(
              _getDisabilityTypeLabel(type),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            value: type,
            groupValue: _disabilityType,
            onChanged: (value) {
              setState(() {
                _disabilityType = value!;
              });
            },
            activeColor: AccessibilityTheme.getAccessibleColor(
              AppTheme.athletePrimary,
            ),
          );
        }).toList(),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 600.ms);
  }

  String _getDisabilityTypeLabel(DisabilityType type) {
    switch (type) {
      case DisabilityType.none:
        return 'No disability';
      case DisabilityType.limb:
        return 'Limb disability';
      case DisabilityType.visual:
        return 'Visual impairment';
      case DisabilityType.hearing:
        return 'Hearing impairment';
      case DisabilityType.other:
        return 'Other';
    }
  }

  Widget _buildParaSportClassification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: Text(
            'I have para-sport classification',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppTheme.highContrastForeground,
            ),
          ),
          value: _hasParaSportClassification,
          onChanged: (value) {
            setState(() {
              _hasParaSportClassification = value!;
            });
          },
          activeColor: AccessibilityTheme.getAccessibleColor(
            AppTheme.athletePrimary,
          ),
        ),
        if (_hasParaSportClassification) ...[
          SizedBox(height: 12.h),
          TextFormField(
            controller: TextEditingController(
              text: _paraSportOrganization ?? '',
            ),
            decoration: AccessibilityTheme.createAccessibleInputDecoration(
              labelText: 'Para-sport Organization',
              hintText: 'e.g., IPC, IBSA',
              borderColor: AppTheme.textSecondary,
              focusedBorderColor: AppTheme.athletePrimary,
            ),
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppTheme.highContrastForeground,
            ),
            onChanged: (value) {
              _paraSportOrganization = value;
            },
          ),
        ],
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 1000.ms);
  }

  Widget _buildSportInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Sport Information',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.athletePrimary,
          ),
        ).animate().fadeIn(delay: 200.ms),
        SizedBox(height: 24.h),
        // Sport Selection
        _buildSportSelection(),
        SizedBox(height: 24.h),
        // Participation Level
        _buildParticipationLevelSelector(),
        SizedBox(height: 24.h),
        // Bio
        TextFormField(
          controller: _bioController,
          decoration: AccessibilityTheme.createAccessibleInputDecoration(
            labelText: 'Bio (Optional)',
            hintText: 'Tell us about yourself',
            borderColor: AppTheme.textSecondary,
            focusedBorderColor: AppTheme.athletePrimary,
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

  Widget _buildSportSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your sports:',
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
          children: SportType.values.map((sport) {
            final isSelected = _selectedSports.contains(sport);
            return FilterChip(
              label: Text(
                _getSportTypeLabel(sport),
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
                    _selectedSports.add(sport);
                  } else {
                    _selectedSports.remove(sport);
                  }
                });
              },
              selectedColor: AccessibilityTheme.getAccessibleColor(
                AppTheme.athletePrimary,
              ),
              checkmarkColor: AppTheme.backgroundDark,
            );
          }).toList(),
        ),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 400.ms);
  }

  String _getSportTypeLabel(SportType sport) {
    switch (sport) {
      case SportType.basketball:
        return 'Basketball';
      case SportType.football:
        return 'Football';
      case SportType.tennis:
        return 'Tennis';
      case SportType.swimming:
        return 'Swimming';
      case SportType.athletics:
        return 'Athletics';
      case SportType.cycling:
        return 'Cycling';
      case SportType.wheelchairBasketball:
        return 'Wheelchair Basketball';
      case SportType.wheelchairTennis:
        return 'Wheelchair Tennis';
      case SportType.paraSwimming:
        return 'Para Swimming';
      case SportType.paraAthletics:
        return 'Para Athletics';
      case SportType.other:
        return 'Other';
    }
  }

  Widget _buildParticipationLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Participation Level:',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.highContrastForeground,
          ),
        ),
        SizedBox(height: 12.h),
        ...ParticipationLevel.values.map((level) {
          return RadioListTile<ParticipationLevel>(
            title: Text(
              _getParticipationLevelLabel(level),
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppTheme.highContrastForeground,
              ),
            ),
            value: level,
            groupValue: _participationLevel,
            onChanged: (value) {
              setState(() {
                _participationLevel = value!;
              });
            },
            activeColor: AccessibilityTheme.getAccessibleColor(
              AppTheme.athletePrimary,
            ),
          );
        }).toList(),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 600.ms);
  }

  String _getParticipationLevelLabel(ParticipationLevel level) {
    switch (level) {
      case ParticipationLevel.beginner:
        return 'Beginner';
      case ParticipationLevel.intermediate:
        return 'Intermediate';
      case ParticipationLevel.advanced:
        return 'Advanced';
      case ParticipationLevel.professional:
        return 'Professional';
    }
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
              backgroundColor: AppTheme.athletePrimary,
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
