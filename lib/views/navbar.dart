import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/home/home_screen.dart';
import 'package:sinchai_sathi/views/irrigation/irrigation_screen.dart';
import 'package:sinchai_sathi/views/market/market_Screen.dart';
import 'package:sinchai_sathi/views/profile/profile_page.dart';
import 'package:sinchai_sathi/views/weather/weather_Screen.dart';

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
    const ProfilePage(),
  ];

  final List<BottomNavigationBarItem> userNavigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.contact_mail_rounded),
      label: 'Weather',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Irrigation',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.feedback),
      label: 'Market Place',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
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
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
            selectedItemColor: SColors.secondPrimary,
            unselectedItemColor: Colors.grey[700],
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
