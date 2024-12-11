import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/auth/signup_screen.dart';
import 'package:sinchai_sathi/sinchai_sathi/widgets/elevated_button.dart';
import 'package:sinchai_sathi/sinchai_sathi/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _contactNumberController =
      TextEditingController();

  Future<void> _login() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Image.asset("assets/logos/hero1.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Login",
                      style: GoogleFonts.poppins(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    STextField(
                        labelText: 'Contact Number',
                        controller: _contactNumberController),
                    const SizedBox(height: 40),
                    SElevatedButton(text: 'Login', onPressed: _login),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create an account now!",
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: SColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
