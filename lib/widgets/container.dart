import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';

class SContainer extends StatelessWidget {
  const SContainer({
    super.key,
    required this.child,
    required this.icon,
  });

  final Widget child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff6B8E23), Color(0xff7A9D2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: SColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        height: 150.0,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: child,
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(
                icon,
                size: 50.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
