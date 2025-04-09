import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';

void main() => runApp(const BreatheEasyApp());

class BreatheEasyApp extends StatefulWidget {
  const BreatheEasyApp({super.key});

  @override
  State<BreatheEasyApp> createState() => _BreatheEasyAppState();
}

class _BreatheEasyAppState extends State<BreatheEasyApp> {
  bool isDarkMode = DateTime.now().hour >= 18 || DateTime.now().hour < 6;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breathe Easy',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomeScreen(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
    );
  }
}
