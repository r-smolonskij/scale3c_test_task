import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/auth.dart';
import 'package:test_task/providers/profile_provider.dart';
import 'package:test_task/screens/profile_screen.dart';
import 'package:test_task/screens/sign_in_screen.dart';

class AuthTree extends StatefulWidget {
  const AuthTree({super.key});

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<ProfileInfo>().assignProfile(snapshot.data);
            });
            return ProfileScreen();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<ProfileInfo>().removeProfile();
            });
            return SignInScreen();
          }
        });
  }
}
