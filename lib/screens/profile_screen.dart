import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:test_task/components/base/CustomDynamicButton.dart';
import 'package:test_task/components/base/CustomLoader.dart';
import 'package:test_task/components/base/CustomTextButton.dart';
import 'package:test_task/components/base/CustomTextField.dart';
import 'package:test_task/components/layouts/DefaultLayout.dart';
import 'package:test_task/components/profile/AdditionalInfoBox.dart';
import 'package:test_task/constants.dart';
import 'package:test_task/helperFunctions.dart';
import 'package:test_task/providers/profile_provider.dart';
import 'package:test_task/screens/sign_in_screen.dart';
import 'package:test_task/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var profileInfoBoxesData = [
    {
      "iconPath": "assets/icons/PhoneIcon.svg",
      "titleText": "Phone number",
      "contentText": "+3788888888"
    },
    {
      "iconPath": "assets/icons/MailIcon.svg",
      "titleText": "Email",
      "contentText": ""
    },
    {
      "iconPath": "assets/icons/CircleIcon.svg",
      "titleText": "Completed projects",
      "contentText": "248"
    },
  ];

  onLogoutClick() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Auth().signOut();
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
      );
      context.read<ProfileInfo>().removeProfile();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    var contentHeight =
        MediaQuery.of(context).size.height - statusBarHeight - 100;
    return DefaultLayout(
      pageTitle: "",
      customPadding: EdgeInsets.only(top: 40),
      showBackButton: false,
      child: SingleChildScrollView(
        child: isLoading
            ? CustomLoader()
            : Container(
                constraints: BoxConstraints(minHeight: contentHeight),
                color: secondaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Center(
                              child:
                                  Image.asset("assets/images/Img_Profile.png")),
                          SizedBox(height: 30),
                          Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
                                        2,
                                child: Text(
                                  "New York",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: secondaryColor),
                                ),
                              ),
                              Container(
                                width: 40,
                                child: Center(
                                  child: Icon(
                                    Icons.circle,
                                    color: Color(0xffB5C3C7),
                                    size: 10,
                                  ),
                                ),
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
                                        2,
                                child: Text(
                                  textAlign: TextAlign.start,
                                  "ID: ${context.watch<ProfileInfo>().profileInfo?.uid}",
                                  style: TextStyle(
                                      fontSize: 16, color: secondaryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: macaroniAndCheeseColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextButton(
                                onClick: () {},
                                width:
                                    (MediaQuery.of(context).size.width - 75) /
                                        2,
                                text: "About Me",
                                backgroundColor: Colors.transparent,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                                border: Border.all(
                                    width: 1,
                                    color: transparentButtonsBorderColor),
                              ),
                              CustomTextButton(
                                onClick: () => onLogoutClick(),
                                width:
                                    (MediaQuery.of(context).size.width - 75) /
                                        2,
                                text: "Log Out",
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                    Container(
                      color: secondaryColor,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(30, 40, 30, 24),
                      child: Column(
                        children: profileInfoBoxesData
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: AdditionalInfoBox(
                                    contentText: item["titleText"] == 'Email'
                                        ? "${context.watch<ProfileInfo>().profileInfo?.email}"
                                        : '${item["contentText"]}',
                                    iconPath: '${item["iconPath"]}',
                                    titleText: '${item["titleText"]}',
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
