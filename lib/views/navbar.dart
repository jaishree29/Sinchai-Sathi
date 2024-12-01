import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/home/home_screen.dart';
import 'package:sinchai_sathi/views/irrigation/irrigation_screen.dart';
import 'package:sinchai_sathi/views/market/market_screen.dart';
import 'package:sinchai_sathi/views/profile/profile_page.dart';
import 'package:sinchai_sathi/views/weather/weather_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    List screenList = [
      const HomeScreen(),
      const WeatherScreen(),
      const IrrigationScreen(),
      const MarketScreen(),
      const ProfilePage()
    ];
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        height: 65,
        backgroundColor: SColors.primary,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.cloud, title: 'Weather'),
          TabItem(icon: Icons.energy_savings_leaf_rounded, title: 'Irrigation'),
          TabItem(icon: Icons.location_on_rounded, title: 'Market'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        onTap: (int i) {
          setState(() {
            screenIndex = i;
          });
        },
      ),
      body: screenList[screenIndex],
    );
  }
}
