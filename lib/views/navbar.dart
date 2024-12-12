import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/analysis/soil_analysis.dart';
import 'package:sinchai_sathi/views/home/home_screen.dart';
import 'package:sinchai_sathi/views/irrigation/irrigation_screen.dart';
import 'package:sinchai_sathi/views/market/crop_price_screen.dart';
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
      const CropPriceScreen(),
      const SoilAnalysis(),
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
          TabItem(icon: Icons.data_exploration_rounded, title: 'Analysis'),
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
