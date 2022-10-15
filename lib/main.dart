import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itech/Screens/Auth/Login.dart';
import 'package:itech/screens/home/home.dart';
import 'package:itech/screens/home/home_teacher.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ITECH',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenView(
        navigateRoute: LoginPage(),
        duration: 3000,
        imageSize: 200,
        imageSrc: "assets/images/logo.png",
        backgroundColor: Colors.white,
      ),
    );
  }
}
