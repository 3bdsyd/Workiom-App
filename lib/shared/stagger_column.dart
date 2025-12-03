import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StaggerColumn extends StatelessWidget {
  const StaggerColumn({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children
          .animate(interval: const Duration(milliseconds: 80))
          .fadeIn(duration: const Duration(milliseconds: 350))
          .slideY(
            begin: 0.1,
            end: 0,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOutCubic,
          ),
    );
  }
}
