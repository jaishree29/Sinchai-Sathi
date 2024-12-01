import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/views/alerts/notifications.dart';
import 'package:sinchai_sathi/views/home/app_drawer.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
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
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          splashColor: Colors.transparent,
          onTap: _toggleDrawer,
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1733061873~exp=1733065473~hmac=83a766b2a8964bbdeaae2af625097b00706a4905eddb342aadc9b01a6ccaedf1&w=1380',
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Sarthak',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: SColors.primary),
                ),
              ],
            ),
            InkWell(
              splashColor: SColors.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Notifications(),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications_active_rounded,
                  size: 30,
                  color: SColors.primary,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Homepage content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                SContainer(
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
                SContainer(
                  icon: Icons.severe_cold,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Gurugram, 3 December",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "35° C",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Perception of rain: 14%",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5.0,
                      )
                    ],
                  ),
                ),
                SContainer(
                  icon: Icons.clean_hands_sharp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.upload,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 21.0,
                          ),
                          Text("Upload picture of crop",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 21.0,
                          ),
                          Text("See Diagnosis",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.clean_hands_sharp,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 21.0,
                          ),
                          Text("Get Treatment",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                SContainer(
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
                                  fontWeight: FontWeight.w600, fontSize: 20.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
    );
  }
}
