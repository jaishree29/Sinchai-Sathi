import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sinchai_sathi/sinchai_sathi/controllers/auth_controller.dart';
// import 'package:sinchai_sathi/sinchai_sathi/models/user.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/auth/login_screen.dart';
// import 'package:sinchai_sathi/sinchai_sathi/views/navbar.dart';
// import 'package:sinchai_sathi/sinchai_sathi/views/splash_screen.dart';
import 'package:sinchai_sathi/sinchai_sathi/widgets/elevated_button.dart';
import 'package:sinchai_sathi/sinchai_sathi/widgets/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cropTypeController = TextEditingController();
  final TextEditingController _waterPumpWattController =
      TextEditingController();

  Future<void> _signup() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset("assets/logos/hero1.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Signup",
                      style: GoogleFonts.poppins(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    STextField(
                      labelText: 'Name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 10),
                    STextField(
                        labelText: 'Contact Number',
                        controller: _contactNumberController),
                    const SizedBox(height: 10),
                    STextField(
                      labelText: 'Location',
                      controller: _locationController,
                    ),
                    const SizedBox(height: 10),
                    STextField(
                      labelText: 'Crop Type',
                      controller: _cropTypeController,
                    ),
                    const SizedBox(height: 10),
                    STextField(
                      labelText: 'Water Pump Watt',
                      controller: _waterPumpWattController,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                SElevatedButton(
                  text: 'Signup',
                  onPressed: _signup,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a user?",
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                      child: Text(
                        "Sign in",
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
