import 'package:flutter/material.dart';

class SlideFadeAnimationOffline extends StatefulWidget {
  final Widget child;
  final int delay; // بالملي ثانية

  const SlideFadeAnimationOffline({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<SlideFadeAnimationOffline> createState() => _SlideFadeAnimationState();
}

class _SlideFadeAnimationState extends State<SlideFadeAnimationOffline> {
  bool start = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) setState(() => start = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 تحديد اتجاه التطبيق
    bool isArabic = Directionality.of(context) == TextDirection.rtl;

    // إذا عربي يبدأ من اليمين، إذا إنجليزي يبدأ من اليسار
    Offset beginOffset = isArabic
        ? const Offset(0.3, 0) // من اليمين
        : const Offset(-0.3, 0); // من اليسار

    return TweenAnimationBuilder<Offset>(
      tween: Tween(
        begin: beginOffset,
        end: start ? Offset.zero : beginOffset,
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
