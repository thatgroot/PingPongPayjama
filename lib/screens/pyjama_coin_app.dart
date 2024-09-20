import 'package:flutter/material.dart';
import 'package:pyjama_pingpong/screens/splash_screen.dart';
import 'package:pyjama_pingpong/services/context_utility.dart';

class PyjamaCoinApp extends StatelessWidget {
  const PyjamaCoinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: ContextUtility.navigatorKey,
      title: 'PyjamaCoin',
      theme: ThemeData(
        primaryColor: const Color(0xFF1F1B35),
        scaffoldBackgroundColor: const Color(0xFF1F1B35),
      ),
      home: const SplashScreen(),
    );
  }
}
