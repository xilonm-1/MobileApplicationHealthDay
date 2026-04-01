import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const HealthDayApp());
}

class HealthDayApp extends StatelessWidget {
  const HealthDayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthDay',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainScreen(),
      },
    );
  }
}