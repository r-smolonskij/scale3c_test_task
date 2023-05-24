import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/constants.dart';

class DefaultLayout extends StatelessWidget {
  final String pageTitle;
  final Widget child;
  final Function? onBackClick;
  final bool showBackButton;
  final EdgeInsets? customPadding;

  const DefaultLayout(
      {this.pageTitle = "",
      this.showBackButton = true,
      this.onBackClick,
      this.customPadding,
      required this.child,
      super.key});

  onBackButtonClick(context) {
    if (onBackClick != null) {
      onBackClick!();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100 + statusBarHeight),
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, statusBarHeight + 16, 30, 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showBackButton
                    ? GestureDetector(
                        onTap: () => onBackButtonClick(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        ),
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Text(
                  "$pageTitle",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset("assets/icons/Menu.svg"),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: customPadding ?? EdgeInsets.fromLTRB(30, 40, 30, 30),
          child: child,
        ),
      ),
    );
  }
}
