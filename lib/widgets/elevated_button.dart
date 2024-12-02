import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';

class SElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SElevatedButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: SColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(text),
    );
  }
}
