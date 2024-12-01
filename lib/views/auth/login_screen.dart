import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/navbar.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/hero1.png"),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45.0),
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                        fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        icon: Icon(Icons.phone_android)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50.0,
                        width: 140.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Navbar()));
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 20.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
