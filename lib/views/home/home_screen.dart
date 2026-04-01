import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sinchai_sathi/models/weather_model.dart';
import 'package:sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';
import 'package:sinchai_sathi/views/alerts/notifications.dart';
import 'package:sinchai_sathi/views/analysis/soil_analysis.dart';
import 'package:sinchai_sathi/views/home/about_crops_screen.dart';
import 'package:sinchai_sathi/views/home/app_drawer.dart';
import 'package:sinchai_sathi/views/irrigation/irrigation_screen.dart';
import 'package:sinchai_sathi/views/weather/weather_screen.dart';
import 'package:sinchai_sathi/widgets/circular_container.dart';
import 'package:sinchai_sathi/widgets/container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isDrawerOpen = false;

  String userName = '';
  String token = '';
  Map<String, dynamic>? weatherData;
  late Future<WeatherData> _weatherFuture;
  late String formattedDate;

  Future<void> _fetchUserDetails() async {
    try {
      final storedName = await SLocalStorage().getUserName();
      final storedToken = await SLocalStorage().getToken();

      if (mounted) {
        setState(() {
          userName = storedName ?? '';
          token = storedToken ?? '';
        });
      }
      print('Token from storage: $storedToken');
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<WeatherData> _getWeatherWithToken() async {
    await _fetchUserDetails();
    if (token.isEmpty) {
       // Try getting token again directly if _fetchUserDetails didn't set it in time (it awaits, so it should be fine)
       // But _fetchUserDetails sets state, which might not reflect in 'token' variable immediately inside this async function? 
       // Actually 'token' is a class member, it should be updated.
       // But just to be safe, I'll read from storage if empty.
       final storedToken = await SLocalStorage().getToken();
       if (storedToken != null) token = storedToken;
    }
    if (token.isEmpty) {
      throw Exception('No authentication token available');
    }
    return ApiService().fetchWeatherForUser(token);
  }

  @override
  void initState() {
    super.initState();
    _weatherFuture = _getWeatherWithToken();
    formattedDate = DateFormat.yMMMMEEEEd().format(DateTime.now());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (_isDrawerOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: SColors.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x206B8E23),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8.0),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: _toggleDrawer,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1595956553066-fe24a8c33395?w=500&auto=format&fit=crop&q=60',
                    ),
                  ),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userName.isNotEmpty ? userName : 'Farmer',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Notifications(),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.notifications_active_rounded,
                            size: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Homepage content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IrrigationScreen(),
                      ),
                    ),
                    child: SContainer(
                      icon: Icons.water_drop,
                      child: Center(
                        child: Text(
                          "Water Irrigation \nBoard",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherScreen(),
                      ),
                    ),
                    child: SContainer(
                      icon: Icons.severe_cold,
                      child: FutureBuilder<WeatherData>(
                        future: _weatherFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            print('Weather fetch error: ${snapshot.error}');
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Error loading weather\n$formattedDate",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            );
                          } else if (!snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Location not available\n$formattedDate",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "--° C",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Perception of rain: --%",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            );
                          } else {
                            print("Weather Data: ${snapshot.data}");
                            final weatherData = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${weatherData.location.name}, ${weatherData.location.region}\n$formattedDate",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${weatherData.current.temperature}° C",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Humidity: ${weatherData.current.humidity}%",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5.0)
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SoilAnalysis(),
                      ),
                    ),
                    child: SContainer(
                      icon: Icons.energy_savings_leaf,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 80.0,
                            width: 190.0,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Soil Analysis",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "About Crops",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AboutCropsScreen())),
                        child: const Text(
                          "See all",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SCircularContainer(
                        title: 'Potato',
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1518977676651-b471f97c9079?w=500&auto=format&fit=crop&q=60',
                        ),
                      ),
                      SCircularContainer(
                        title: 'Wheat',
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=500&auto=format&fit=crop&q=60',
                        ),
                      ),
                      SCircularContainer(
                        title: 'Tomato',
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=500&auto=format&fit=crop&q=60',
                        ),
                      ),
                      SCircularContainer(
                        title: 'Lettuce',
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?w=500&auto=format&fit=crop&q=60',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Drawer
            Visibility(
              visible: _isDrawerOpen,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SlideTransition(
                  position: _animation,
                  child: const SAppDrawer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
