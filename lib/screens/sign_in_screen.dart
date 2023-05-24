import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:test_task/components/base/CustomDynamicButton.dart';
import 'package:test_task/components/base/CustomLoader.dart';
import 'package:test_task/components/base/CustomTextButton.dart';
import 'package:test_task/components/base/CustomTextField.dart';
import 'package:test_task/components/layouts/DefaultLayout.dart';
import 'package:test_task/constants.dart';
import 'package:test_task/helperFunctions.dart';
import 'package:test_task/providers/profile_provider.dart';
import 'package:test_task/screens/profile_screen.dart';
import 'package:test_task/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage = '';

  goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingUpScreen(),
      ),
    );
  }

  onLoginClick() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });
    var emailText = emailController.text;
    var passwordText = passwordController.text;
    String? newError = "";
    if (emailText.isEmpty || !checkIfEmailValid(emailText)) {
      newError = "Incorrect email format";
    } else if (passwordText.isEmpty) {
      newError = "Password is empty";
    } else {
      try {
        await Auth().signInWithEmailAndPassword(
          email: emailText,
          password: passwordText,
        );
        setState(() {
          isLoading = false;
        });
        context.read<ProfileInfo>().assignProfile(Auth().currentUser);
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
      if (newError!.isNotEmpty) {
        setState(() {
          errorMessage = newError;
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      pageTitle: "Sign In",
      showBackButton: false,
      child: SingleChildScrollView(
        child: isLoading
            ? CustomLoader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("assets/images/SignInImage.png")),
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
                    height: 14,
                  ),
                  if (errorMessage != null && errorMessage!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "$errorMessage",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: secondaryColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomTextButton(
                    text: "Login",
                    onClick: () => onLoginClick(),
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
                            child: SvgPicture.asset(
                                "assets/icons/TwitterIcon.svg")),
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
                          TextSpan(text: 'Don’t have an account? '),
                          TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: macaroniAndCheeseColor,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  goToSignUp();
                                })
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
