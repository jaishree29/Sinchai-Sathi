import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/navbar.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Navbar()));
        },
        backgroundColor: SColors.primary,
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/logos/hero1.png"),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: Text(
                  "Signup",
                  style: GoogleFonts.poppins(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Phone Number",
                      icon: Icon(Icons.phone_android)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Full Name", icon: Icon(Icons.person)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  children: [
                    Checkbox(
                        value: false,
                        activeColor: SColors.primary,
                        onChanged: (bool? newValue) {}),
                    Expanded(
                        child: Text(
                      "By singing up you are agreeing to our Privacy policy & T&C",
                      style: GoogleFonts.poppins(fontSize: 12.0),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
