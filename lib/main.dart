import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'theme/accessibility_theme.dart';
import 'providers/app_provider.dart';
import 'models/user.dart';

void main() {
  runApp(const TrueScoreApp());
}

class TrueScoreApp extends StatelessWidget {
  const TrueScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Consumer<AppProvider>(
            builder: (context, appProvider, _) {
              return MaterialApp(
                title: 'TrueScore',
                debugShowCheckedModeBanner: false,
                theme: _getTheme(appProvider),
                home: const SplashScreen(),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(
                        AccessibilityTheme.fontSizeMultiplier,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  ThemeData _getTheme(AppProvider appProvider) {
    if (AccessibilityTheme.isHighContrast) {
      return AppTheme.highContrastTheme;
    } else if (AccessibilityTheme.isColorBlindFriendly) {
      return AppTheme.colorBlindFriendlyTheme;
    } else if (appProvider.userRole == UserRole.athlete ||
        appProvider.userRole == UserRole.paraAthlete) {
      return AppTheme.athleteTheme;
    } else {
      return AppTheme.officialTheme;
    }
  }
}
