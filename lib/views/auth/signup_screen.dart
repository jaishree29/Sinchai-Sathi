import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinchai_sathi/controllers/auth_controller.dart';
import 'package:sinchai_sathi/models/user.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/auth/login_screen.dart';
import 'package:sinchai_sathi/views/navbar.dart';
import 'package:sinchai_sathi/widgets/elevated_button.dart';
import 'package:sinchai_sathi/widgets/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController _authController = AuthController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cropTypeController = TextEditingController();
  final TextEditingController _pumpWattController = TextEditingController();
  final TextEditingController _irrigationStateController =
      TextEditingController();
  bool _isLoading = false;

  Future<void> _signup() async {
    setState(() => _isLoading = true);
    try {
      final farmer = Farmer(
        id: '',
        name: _nameController.text,
        contactNumber: _contactController.text,
        location: _locationController.text,
        cropType: _cropTypeController.text,
        waterPumpWatt: int.parse(_pumpWattController.text),
        irrigationState: _irrigationStateController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _authController.signup(farmer);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Navbar()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sinchai Sathi",
                      style: GoogleFonts.poppins(
                        fontSize: 25.0,
                        color: SColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Let's help you start your journey as a farmer with us!",
                      style: GoogleFonts.poppins(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Please fill in all the details below.",
                      style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    STextField(
                      labelText: 'Name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 10),
                    STextField(
                      labelText: 'Contact Number',
                      controller: _contactController,
                    ),
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
                      controller: _pumpWattController,
                    ),
                    const SizedBox(height: 10),
                    STextField(
                      labelText: 'Irrigation State',
                      controller: _irrigationStateController,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SElevatedButton(
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
