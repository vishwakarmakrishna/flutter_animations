import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AnimationShowcaseApp());
}

class AnimationShowcaseApp extends StatelessWidget {
  const AnimationShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Showcase',
      debugShowCheckedModeBanner: false,
      // darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
