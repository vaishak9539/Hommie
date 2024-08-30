import 'package:flutter/material.dart';

class CustomInkwellButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final Color color;
  final double borderRadius;

  CustomInkwellButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width = 161,
    this.height = 50,
    this.color =  Colors.teal,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,  
      child: InkWell(
        onTap:onTap,
        borderRadius: BorderRadius.circular(borderRadius),  
        splashColor: Colors.white.withOpacity(0.2),         
        highlightColor: Colors.white.withOpacity(0.1),      
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
