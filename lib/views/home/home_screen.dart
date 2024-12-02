import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';
import 'package:sinchai_sathi/views/alerts/notifications.dart';
import 'package:sinchai_sathi/views/home/about_crops_screen.dart';
import 'package:sinchai_sathi/views/home/app_drawer.dart';
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

  Future<void> _fetchUserDetails() async {
    String? name = await SLocalStorage().getUserName();
    setState(() {
      userName = name ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  userName.isNotEmpty ? userName : 'User',
                  style: const TextStyle(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 10.0,
                // ),
                const Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
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
                // SContainer(
                //   icon: Icons.clean_hands_sharp,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Row(
                //         children: [
                //           const Icon(
                //             Icons.upload,
                //             color: Colors.white,
                //           ),
                //           const SizedBox(
                //             width: 21.0,
                //           ),
                //           Text("Upload picture of crop",
                //               style: GoogleFonts.poppins(
                //                   color: Colors.white,
                //                   fontSize: 12.0,
                //                   fontWeight: FontWeight.w500)),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           const Icon(
                //             Icons.search_outlined,
                //             color: Colors.white,
                //           ),
                //           const SizedBox(
                //             width: 21.0,
                //           ),
                //           Text("See Diagnosis",
                //               style: GoogleFonts.poppins(
                //                   color: Colors.white,
                //                   fontSize: 12.0,
                //                   fontWeight: FontWeight.w500)),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           const Icon(
                //             Icons.clean_hands_sharp,
                //             color: Colors.white,
                //           ),
                //           const SizedBox(
                //             width: 21.0,
                //           ),
                //           Text("Get Treatment",
                //               style: GoogleFonts.poppins(
                //                   color: Colors.white,
                //                   fontSize: 12.0,
                //                   fontWeight: FontWeight.w500)),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "About Crops",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutCropsScreen())),
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
                        'https://img.freepik.com/free-photo/potatoes-closeup-as-background-top-view_176474-2023.jpg?t=st=1733073128~exp=1733076728~hmac=13ef1c000f3c3f3965d6a0f8ac680aef83fa1d8479fe4bac691d65801cb7b8d0&w=1380',
                      ),
                    ),
                    SCircularContainer(
                      title: 'Wheat',
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/wheat-field-waving-wind-field-background_1268-30583.jpg?t=st=1733072854~exp=1733076454~hmac=2fdb9a6de8021d4fd68337284ca5f68a90754cbdc9144b01b8fc41ecfb265542&w=1380',
                      ),
                    ),
                    SCircularContainer(
                      title: 'Tomato',
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/fresh-wet-tomatoes_144627-24355.jpg?t=st=1733073240~exp=1733076840~hmac=65cd6adca0d75b9b2d0347a5b5b5b327dee0e4afe0773c3ed2b37d004c942424&w=740',
                      ),
                    ),
                    SCircularContainer(
                      title: 'Lettuce',
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/lettuce-closeup-texture-background_144627-30014.jpg?t=st=1733073423~exp=1733077023~hmac=83d298b4eb9e64eb6cbe578e9bb986e629eefccd8ee1c6df8c9d20f20f1b4de2&w=1380',
                      ),
                    ),
                  ],
                )
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
