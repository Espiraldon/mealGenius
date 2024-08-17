import 'package:flutter/material.dart';
import 'dart:async';

class DelayedAnimated extends StatefulWidget {
  final Widget child;
  final int delay;
  const DelayedAnimated({super.key, required this.child, required this.delay});

  @override
  State<DelayedAnimated> createState() => _DelayedAnimatedState();
}

class _DelayedAnimatedState extends State<DelayedAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    final curve =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _animationOffset = Tween<Offset>(
      begin: const Offset(0.0, -0.2),
      end: Offset.zero,
    ).animate(curve);
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animationOffset,
        child: widget.child,
      ),
    );
  }
}
