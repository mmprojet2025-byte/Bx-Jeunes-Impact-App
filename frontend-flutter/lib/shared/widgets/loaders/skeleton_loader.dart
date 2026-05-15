import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class SkeletonBox extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  const SkeletonBox({super.key, required this.width, required this.height, this.radius = 8});
 
  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}
 
class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
        ..repeat(reverse: true);
 
  @override
  void dispose() { _ac.dispose(); super.dispose(); }
 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ac,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: Color.lerp(AppColors.shimmer, AppColors.border, _ac.value),
        ),
      ),
    );
  }
}
 
/// Card skeleton (reusable placeholder for list items)
class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: [
        SkeletonBox(width: 52, height: 52, radius: 12),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(width: double.infinity, height: 14),
            const SizedBox(height: 8),
            SkeletonBox(width: 120, height: 12),
            const SizedBox(height: 6),
            SkeletonBox(width: 80, height: 12),
          ],
        ),
        ),
      ],
      ),
    );
  }
}
