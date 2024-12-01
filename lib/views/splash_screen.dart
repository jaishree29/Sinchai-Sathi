import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/auth/signup_screen.dart';

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
    // var sharedPref = await SharedPreferences.getInstance();
    // var isLoggedIn = sharedPref.getBool(loginKey);
    Timer(const Duration(seconds: 3), () {
      // if (isLoggedIn != null) {
      //   if (isLoggedIn) {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => const Navbar()));
      //   } else {
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => const SignupScreen()),
      //     );
      //   }
      // } else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const SignupScreen()),
      //   );
      // }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              child:
                  AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
                FadeAnimatedText(
                  'Sinchai Sathi',
                  duration: const Duration(seconds: 3),
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
