import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_task/auth_tree.dart';
import 'package:test_task/constants.dart';
import 'package:test_task/providers/profile_provider.dart';
import 'package:test_task/screens/sign_in_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProfileInfo()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: primaryColor, displayColor: primaryColor),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthTree(),
    );
  }
}
