import 'package:flutter/material.dart';
import 'screens/splash.dart';

void main() {
  runApp(const JustinBieberQuizApp());
}

class JustinBieberQuizApp extends StatelessWidget {
  const JustinBieberQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Justin Bieber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}