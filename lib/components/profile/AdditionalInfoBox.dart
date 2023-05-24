import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/constants.dart';

class AdditionalInfoBox extends StatelessWidget {
  final String iconPath, titleText, contentText;
  const AdditionalInfoBox(
      {this.iconPath = "",
      this.contentText = "",
      this.titleText = "",
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: transparentButtonsBorderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 22,
              child: SvgPicture.asset(iconPath),
            ),
            SizedBox(width: 25),
            Container(
              height: 42,
              width: 1,
              color: transparentButtonsBorderColor,
            ),
            SizedBox(width: 22),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.38),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    contentText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
