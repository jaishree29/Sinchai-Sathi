import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sinchai_sathi/views/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}