import 'package:flutter/material.dart';

class BreathingCircle extends StatefulWidget {
  final bool isPlaying;
  const BreathingCircle({super.key, required this.isPlaying});

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // 2s inhale, 2s exhale
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = ColorTween(
      begin: Colors.teal.shade100,
      end: Colors.teal.shade400,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isPlaying) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant BreathingCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('🫁', style: TextStyle(fontSize: 48)),
            ),
          ),
        );
      },
    );
  }
}
