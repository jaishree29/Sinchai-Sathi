import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/utils/image_strings.dart';
import 'package:sinchai_sathi/views/auth/signup_screen.dart';
import 'package:sinchai_sathi/views/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String loginKey = 'Login';
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(loginKey);
    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Navbar()));
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignupScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignupScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            SImages.logo,
            width: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 50,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: SColors.secondPrimary,
              ),
              child:
                  AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
                TyperAnimatedText('Localeezy', speed: Durations.short3),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
