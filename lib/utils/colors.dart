import 'dart:ui';
import 'package:flutter/material.dart';

class SColors {
  // Primary Colors - Agricultural Green Theme
  static const Color primary = Color(0xff6B8E23); // Olive Drab
  static const Color primaryLight = Color(0xff8FBC3F);
  static const Color primaryDark = Color(0xff556B2F);
  static const Color secondPrimary = Color(0xff00b251);
  
  // Accent Colors
  static const Color accent = Color(0xffFFB74D); // Warm Orange
  static const Color accentLight = Color(0xffFFCC80);
  
  // Background Colors
  static const Color background = Color(0xffF5F7FA);
  static const Color surface = Color(0xffFFFFFF);
  static const Color surfaceVariant = Color(0xffF0F4F8);
  
  // Semantic Colors
  static const Color success = Color(0xff4CAF50);
  static const Color warning = Color(0xffFF9800);
  static const Color error = Color(0xffF44336);
  static const Color info = Color(0xff2196F3);
  
  // Text Colors
  static const Color textPrimary = Color(0xff1A1A1A);
  static const Color textSecondary = Color(0xff757575);
  static const Color textLight = Color(0xffBDBDBD);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xff6B8E23), Color(0xff8FBC3F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xffFFB74D), Color(0xffFF9800)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xffFFFFFF), Color(0xffF5F7FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.05);
  static Color shadowMedium = Colors.black.withOpacity(0.1);
  static Color shadowDark = Colors.black.withOpacity(0.15);
}