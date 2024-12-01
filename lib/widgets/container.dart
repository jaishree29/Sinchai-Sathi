import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';

class SContainer extends StatelessWidget {
  const SContainer({
    super.key,
    required this.child,
    required this.icon,
  });

  final child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 140.0,
          width: double.infinity,
          child: Card(
            elevation: 10.0,
            color: SColors.primary,
            child: ListTile(
              title: Padding(
                  padding: const EdgeInsets.all(2.2), child: child),
              trailing: Icon(
                icon,
                size: 60.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
