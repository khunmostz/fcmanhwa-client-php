import 'package:flutter/material.dart';
import 'package:flutter_client_fcmanhwa/screens/homeScreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenView(
          navigateRoute: HomeScreen(),
          duration: 5000,
          imageSize: 130,
          imageSrc: "assets/images/MANGA-LOGO.png",
          text: "MANGA",
          textType: TextType.ColorizeAnimationText,
          textStyle: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
          colors: [
            Colors.black,
            Colors.red,
            Colors.black,
            Colors.red,
          ],
          backgroundColor: Colors.white,
        ));
  }
}
