import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/local_storage.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/auth/signup_screen.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/splash_screen.dart';
import 'package:sinchai_sathi/sinchai_sathi/widgets/elevated_button.dart';

class SAppDrawer extends StatefulWidget {
  const SAppDrawer({super.key});

  @override
  State<SAppDrawer> createState() => _SAppDrawerState();
}

class _SAppDrawerState extends State<SAppDrawer> {
  // User log out
  Future<void> _userLogOut() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashScreenState.loginKey, false);

    SLocalStorage().clearAll();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      shadowColor: Colors.grey,
      elevation: 5.0,
      shape: const Border(right: BorderSide.none),
      backgroundColor: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Activity'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Order history'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Account'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SElevatedButton(text: 'Log Out', onPressed: _userLogOut),
              ),
            ],
          )
        ],
      ),
    );
  }
}
