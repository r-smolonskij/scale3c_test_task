import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/auth.dart';
import 'package:test_task/components/base/CustomDynamicButton.dart';
import 'package:test_task/components/base/CustomTextButton.dart';
import 'package:test_task/components/base/CustomTextField.dart';
import 'package:test_task/components/layouts/DefaultLayout.dart';
import 'package:test_task/constants.dart';
import 'package:test_task/helperFunctions.dart';
import 'package:test_task/screens/profile_screen.dart';
import 'package:test_task/screens/sign_in_screen.dart';
import 'package:test_task/components/base/CustomLoader.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  String? errorMessage = '';

  goToSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }

  onSignUpClick() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });
    var emailText = emailController.text;
    var passwordText = passwordController.text;
    var passwordConfirmationText = passwordConfirmationController.text;
    String? newError = "";
    if (emailText.isEmpty || !checkIfEmailValid(emailText)) {
      newError = "Incorrect email format";
    } else if (passwordText.isEmpty) {
      newError = "Password is empty";
    } else if (passwordConfirmationText != passwordText) {
      newError = "Passwords does not match";
    } else {
      try {
        await Auth().createUserWithEmailAndPassword(
          email: emailText,
          password: passwordText,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        newError = e.message;
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        errorMessage = newError;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      pageTitle: "Sign up",
      child: isLoading
          ? CustomLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/SignUpImage.png")),
                SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  textController: emailController,
                  hintText: "Email",
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  textController: passwordController,
                  hintText: "Password",
                  isPassword: true,
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  textController: passwordConfirmationController,
                  hintText: "Confirm password",
                  isPassword: true,
                ),
                if (errorMessage != null && errorMessage!.isNotEmpty)
                  Text(
                    "$errorMessage",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                SizedBox(
                  height: 16,
                ),
                CustomTextButton(
                  text: "Sign Up",
                  onClick: () => onSignUpClick(),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "or",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: secondaryColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDynamicButton(
                      onClick: () {},
                      width: (MediaQuery.of(context).size.width - 76) / 3,
                      border: Border.all(
                          width: 1, color: transparentButtonsBorderColor),
                      content: Center(
                          child: SvgPicture.asset(
                              "assets/icons/FacebookIcon.svg")),
                    ),
                    CustomDynamicButton(
                      onClick: () {},
                      width: (MediaQuery.of(context).size.width - 76) / 3,
                      border: Border.all(
                          width: 1, color: transparentButtonsBorderColor),
                      content: Center(
                          child:
                              SvgPicture.asset("assets/icons/TwitterIcon.svg")),
                    ),
                    CustomDynamicButton(
                      onClick: () {},
                      width: (MediaQuery.of(context).size.width - 76) / 3,
                      border: Border.all(
                          width: 1, color: transparentButtonsBorderColor),
                      content: Center(
                          child: SvgPicture.asset(
                              "assets/icons/LinkedinIcon.svg")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                      children: <TextSpan>[
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: macaroniAndCheeseColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                goToSignIn();
                              })
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
