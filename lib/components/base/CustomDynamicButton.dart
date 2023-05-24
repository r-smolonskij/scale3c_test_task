import 'package:flutter/material.dart';

class CustomDynamicButton extends StatelessWidget {
  final double? height, width;
  final Color? backgroundColor;
  final Border? border;
  final Function onClick;
  final Widget content;

  CustomDynamicButton(
      {this.height = 60,
      this.width,
      this.backgroundColor = Colors.transparent,
      this.border,
      this.content = const SizedBox(),
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
        child: content,
      ),
    );
  }
}
