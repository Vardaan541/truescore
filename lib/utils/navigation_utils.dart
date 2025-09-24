import 'package:flutter/material.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/role_selection_screen.dart';
import '../screens/athlete_signup_screen.dart';
import '../screens/official_signup_screen.dart';
import '../screens/athlete_dashboard.dart';
import '../screens/official_dashboard.dart';
import '../models/user.dart';

class NavigationUtils {
  static void navigateToOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  static void navigateToRoleSelection(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
    );
  }

  static void navigateToAthleteSignup(BuildContext context, UserRole role) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AthleteSignupScreen(role: role)),
    );
  }

  static void navigateToOfficialSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OfficialSignupScreen()),
    );
  }

  static void navigateToAthleteDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AthleteDashboard()),
    );
  }

  static void navigateToOfficialDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OfficialDashboard()),
    );
  }
}
