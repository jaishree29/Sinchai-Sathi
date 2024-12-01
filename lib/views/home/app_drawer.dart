import 'package:flutter/material.dart';

class SAppDrawer extends StatelessWidget {
  const SAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.grey,
      elevation: 5.0,
      shape: const Border(right: BorderSide.none),
      backgroundColor:
          Colors.white,
      child: ListView(
        children: <Widget>[
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
        ],
      ),
    );
  }
}
