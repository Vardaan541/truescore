import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../theme/accessibility_theme.dart';
import '../utils/navigation_utils.dart';
import '../widgets/accessibility_toggle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        NavigationUtils.navigateToRoleSelection(context);
      }
    }
  }

  void _handleSignUp() {
    NavigationUtils.navigateToRoleSelection(context);
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Forgot password feature coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),
                // Logo and Title
                _buildHeader(),
                SizedBox(height: 48.h),
                // Welcome Text
                _buildWelcomeText(),
                SizedBox(height: 32.h),
                // Email Field
                _buildEmailField(),
                SizedBox(height: 16.h),
                // Password Field
                _buildPasswordField(),
                SizedBox(height: 8.h),
                // Forgot Password
                _buildForgotPassword(),
                SizedBox(height: 24.h),
                // Login Button
                _buildLoginButton(),
                SizedBox(height: 16.h),
                // Divider
                _buildDivider(),
                SizedBox(height: 16.h),
                // Social Login Buttons
                _buildSocialLoginButtons(),
                SizedBox(height: 24.h),
                // Sign Up Link
                _buildSignUpLink(),
                SizedBox(height: 24.h),
                // Accessibility Toggle
                const AccessibilityToggle(),
              ],
            ),
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
        // App Name
        Text(
          'TrueScore',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.athletePrimary,
          ),
        ).animate().fadeIn(delay: 200.ms),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome back!',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppTheme.highContrastForeground,
          ),
        ).animate().slideY(begin: 0.3, end: 0, delay: 400.ms),
        SizedBox(height: 8.h),
        Text(
          'Sign in to your account',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
          ),
        ).animate().slideY(begin: 0.3, end: 0, delay: 600.ms),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
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
    ).animate().slideX(begin: -0.3, end: 0, delay: 800.ms);
  }

  Widget _buildPasswordField() {
    return TextFormField(
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
    ).animate().slideX(begin: -0.3, end: 0, delay: 1000.ms);
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _handleForgotPassword,
        child: Text(
          'Forgot password?',
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.athletePrimary,
          ),
        ),
      ),
    ).animate().fadeIn(delay: 1200.ms);
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
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
                'Log In',
                style: AccessibilityTheme.createAccessibleTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.backgroundDark,
                ),
              ),
      ),
    ).animate().slideY(begin: 0.3, end: 0, delay: 1400.ms);
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppTheme.textSecondary,
            thickness: AccessibilityTheme.isHighContrast ? 2 : 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'or',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppTheme.textSecondary,
            thickness: AccessibilityTheme.isHighContrast ? 2 : 1,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1600.ms);
  }

  Widget _buildSocialLoginButtons() {
    return Column(
      children: [
        // Google Sign In
        SizedBox(
          height: 50.h,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement Google Sign In
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Google Sign In coming soon!')),
              );
            },
            icon: Icon(
              Icons.g_mobiledata,
              size: AccessibilityTheme.getAccessibleIconSize(24),
              color: AppTheme.textSecondary,
            ),
            label: Text(
              'Continue with Google',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: Colors.transparent,
              foregroundColor: AppTheme.textSecondary,
              borderRadius: 12,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        // Apple Sign In
        SizedBox(
          height: 50.h,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement Apple Sign In
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Apple Sign In coming soon!')),
              );
            },
            icon: Icon(
              Icons.apple,
              size: AccessibilityTheme.getAccessibleIconSize(24),
              color: AppTheme.textSecondary,
            ),
            label: Text(
              'Continue with Apple',
              style: AccessibilityTheme.createAccessibleTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
            style: AccessibilityTheme.createAccessibleButtonStyle(
              backgroundColor: Colors.transparent,
              foregroundColor: AppTheme.textSecondary,
              borderRadius: 12,
            ),
          ),
        ),
      ],
    ).animate().slideY(begin: 0.3, end: 0, delay: 1800.ms);
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AccessibilityTheme.createAccessibleTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppTheme.textSecondary,
          ),
        ),
        TextButton(
          onPressed: _handleSignUp,
          child: Text(
            'Sign up',
            style: AccessibilityTheme.createAccessibleTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.athletePrimary,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 2000.ms);
  }
}
