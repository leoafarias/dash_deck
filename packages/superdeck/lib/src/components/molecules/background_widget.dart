import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../modules/presentation/slide_data.dart';

class BackgroundWidget extends HookWidget {
  const BackgroundWidget(this.configuration,
      {required this.background, super.key});

  final SlideData configuration;
  final Widget? background;

  @override
  Widget build(context) {
    return Builder(builder: (context) {
      return background ?? const SizedBox();
    });
  }
}

class BackgroundFade extends StatefulWidget {
  final Widget child;

  const BackgroundFade({
    super.key,
    required this.child,
  });

  @override
  _BackgroundFadeState createState() => _BackgroundFadeState();
}

class _BackgroundFadeState extends State<BackgroundFade>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 300), // Short duration for fade effect
    );
    _fadeAnimation = Tween(begin: 1.0, end: 1.0)
        .animate(_controller); // Fade in, no fade out
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
