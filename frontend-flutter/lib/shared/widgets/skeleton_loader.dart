import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  final Widget child;
  const SkeletonLoader({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.grey.shade300, Colors.grey.shade100, Colors.grey.shade300],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: child,
    );
  }
}
