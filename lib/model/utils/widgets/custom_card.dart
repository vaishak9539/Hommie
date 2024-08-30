import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? elevation;
  final Color? shadowColor;
  final EdgeInsetsGeometry? margin;
  final ShapeBorder? shape;
  final double borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.elevation,
    this.shadowColor,
    this.margin,
    this.shape,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child,
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      margin: margin,
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
