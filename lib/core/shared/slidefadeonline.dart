import 'package:flutter/material.dart';

class SlideFadeAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final bool animatedBefore; // أضفها
  final VoidCallback onAnimated; // أضفها

  const SlideFadeAnimation({
    super.key,
    required this.child,
    required this.delay,
    required this.animatedBefore,
    required this.onAnimated,
  });

  @override
  State<SlideFadeAnimation> createState() => _SlideFadeAnimationState();
}

class _SlideFadeAnimationState extends State<SlideFadeAnimation> {
  bool start = false;

  @override
  void initState() {
    super.initState();

    if (widget.animatedBefore) {
      // سبق وانعرض → لا أنيميشن
      start = true;
    } else {
      // أول مرة → نفّذ delay
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (!mounted) return;
        setState(() => start = true);
        widget.onAnimated(); // علّم العنصر إنه اشتغل
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(
        begin: start ? Offset.zero : const Offset(-0.3, 0),
        end: Offset.zero,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, offset, child) {
        return Opacity(
          opacity: start ? 1 : 0,
          child: Transform.translate(
            offset: Offset(offset.dx * 100, 0),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
