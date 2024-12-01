import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/home/home_screen.dart';
import 'package:sinchai_sathi/views/irrigation/irrigation_screen.dart';
import 'package:sinchai_sathi/views/market/market_screen.dart';
import 'package:sinchai_sathi/views/weather/weather_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int myCurrentIndex = 0;
  late List<Widget> navigationPages;
  late List<BottomNavigationBarItem> navigationItems;

  @override
  void initState() {
    super.initState();
    initializeNavigation();
  }

  void initializeNavigation() {
    navigationItems = userNavigationItems;
    navigationPages = userNavigation;
  }

  final List<Widget> userNavigation = [
    const HomeScreen(),
    const WeatherScreen(),
    const IrrigationScreen(),
    const MarketScreen(),
  ];

  final List<BottomNavigationBarItem> userNavigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.cloud),
      label: 'Weather',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.water_drop),
      label: 'Irrigation',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.place_rounded),
      label: 'Market',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (navigationItems.isEmpty || navigationPages.isEmpty) {
      initializeNavigation();
    }
    return Scaffold(
      body: navigationPages[myCurrentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            selectedItemColor: SColors.primary,
            unselectedItemColor: Colors.grey[500],
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: navigationItems,
          ),
        ),
      ),
    );
  }
}
