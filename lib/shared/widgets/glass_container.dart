import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Color? color;
  final Widget child;

  const GlassContainer({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final whiteColor = Colors.white;

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? whiteColor.withAlpha(50),
            borderRadius: borderRadius,
            border: Border.all(width: 1.5, color: whiteColor.withAlpha(76)),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
