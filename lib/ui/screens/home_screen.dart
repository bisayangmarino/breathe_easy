import 'package:flutter/material.dart';
import '../widgets/breathing_circle.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;
  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBreathing = false;
  String currentPrompt = '';
  Timer? breathingTimer;
  int step = 0;

  void toggleBreathing() {
    setState(() {
      isBreathing = !isBreathing;
    });

    if (isBreathing) {
      startBreathingCycle();
    } else {
      breathingTimer?.cancel();
      setState(() {
        currentPrompt = "Ready to continue?";
        step = 0;
      });
    }
  }

  void startBreathingCycle() {
    setState(() => currentPrompt = "Inhale deeply through your nose");

    breathingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      step++;

      if (step == 4) {
        setState(() => currentPrompt = "Hold your breath");
      } else if (step == 11) {
        setState(() => currentPrompt = "Exhale slowly through your mouth");
      } else if (step == 19) {
        step = 0;
        setState(() => currentPrompt = "Inhale deeply through your nose");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe Easy'),
        centerTitle: true,
        actions: [
          Row(
            children: [
              const Icon(Icons.light_mode, size: 18),
              Switch(value: widget.isDarkMode, onChanged: widget.toggleTheme),
              const Icon(Icons.dark_mode, size: 18),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  widget.isDarkMode
                      ? [Color(0xFF1A237E), Color(0xFF004D40)]
                      : [Colors.white, Colors.teal.shade50],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Text(
                  currentPrompt.isNotEmpty
                      ? currentPrompt
                      : 'Let\'s breathe together',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: ElevatedButton(
                  onPressed: toggleBreathing,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Tooltip(
                    message: isBreathing ? 'Pause' : 'Start',
                    child: Icon(
                      isBreathing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 32,
                    ),
                  ),
                ),
              ),
              BreathingCircle(isPlaying: isBreathing),
              const SizedBox(height: 20),
              const Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
        },
        child: const Icon(Icons.info),
      ),
    );
  }

  @override
  void dispose() {
    breathingTimer?.cancel();
    super.dispose();
  }
}
