import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final Color? color;
  final double borderRadius;
  final EdgeInsets padding;
  final double elevation;

  const StyledButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // todo: Buat theme
        // backgroundColor: color ?? Theme.of(context).primaryColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
      ),
      child: child,
    );
  }
}
