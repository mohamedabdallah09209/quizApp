import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  const AppCircleButton(
      {super.key,
      this.color,
      this.width = 60,
      this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
