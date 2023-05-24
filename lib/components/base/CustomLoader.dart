import 'package:flutter/material.dart';
import 'package:test_task/constants.dart';

class CustomLoader extends StatelessWidget {
  final double? diameter;
  final Color? color;
  const CustomLoader(
      {this.diameter = 100, this.color = primaryColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: diameter,
        width: diameter,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          color: color,
        ),
      ),
    );
  }
}
