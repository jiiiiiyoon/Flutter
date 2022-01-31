import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shallwe_app/config/color_palette.dart';
import './screens/login/sing_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shall We?',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Palette.mintColor),
      ),
      home: const SignInScreen(),
    );
  }
}
