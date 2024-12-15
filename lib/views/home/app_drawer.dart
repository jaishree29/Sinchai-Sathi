import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';
import 'package:sinchai_sathi/views/auth/signup_screen.dart';
import 'package:sinchai_sathi/views/splash_screen.dart';
import 'package:sinchai_sathi/widgets/elevated_button.dart';

class SAppDrawer extends StatefulWidget {
  const SAppDrawer({super.key});

  @override
  State<SAppDrawer> createState() => _SAppDrawerState();
}

class _SAppDrawerState extends State<SAppDrawer> {
  String? username;
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    fetchUserName();
    super.initState();
  }

  void fetchUserName() async {
    String? name = await SLocalStorage().getUserName();
    String? user = await SLocalStorage().getUserId();
    setState(() {
      username = name;
      userId = user;
    });
  }

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
                leading: const Icon(Icons.person_pin_rounded),
                title: Text('User Id: $userId'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text('$username'),
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
