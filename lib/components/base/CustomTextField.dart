import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool isPassword;
  const CustomTextField(
      {this.hintText = "",
      this.isPassword = false,
      required this.textController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: isPassword,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          hintText: "$hintText",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xffB0B0C3)),
          filled: true,
          fillColor: Color(0xffF7F7F7),
          border: InputBorder.none),
    );
  }
}
