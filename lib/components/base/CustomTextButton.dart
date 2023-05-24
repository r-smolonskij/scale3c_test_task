import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final double? height, width;
  final Color? backgroundColor;
  final Border? border;
  final Function onClick;

  CustomTextButton(
      {this.text = "",
      this.textStyle = const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      this.height = 60,
      this.width,
      this.backgroundColor = const Color(0xff20C3AF),
      this.border,
      required this.onClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onClick()},
      child: Container(
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: backgroundColor, border: border),
        child: Center(
          child: Text(
            "$text",
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
