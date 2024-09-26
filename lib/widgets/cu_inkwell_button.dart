import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomInkwellButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final Color? color;
  final double borderRadius;
  final FontWeight fontWeight;
  final Icon? icon;

  CustomInkwellButton({
    super.key,
    required this.onTap,
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.icon,
    this.width = 161,
    this.height = 50,
    this.color,
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
            color: Color(0xff08A9A9),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
               if (icon != null) ...[
              icon!,
              SizedBox(width: 8),  
            ],
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
