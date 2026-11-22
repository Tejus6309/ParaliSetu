import 'package:flutter/material.dart';

class AppColors {
  // Brand seed & earthy tones from the original design
  static const Color brandSeed = Color(0xFF653848);
  static const Color brandGreen = Color(0xFF3B6320);
  static const Color brandGreenLight = Color(0xFF588B35);
  static const Color brandGolden = Color(0xFFD97706);
  static const Color brandAmberLight = Color(0xFFFEF3C7);
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Colors.white;
  static const Color surfaceMuted = Color(0xFFF3F4F6);
  static const Color border = Color(0xFFE5E7EB);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF6B7280);

  // Status colors
  static const Color activeGreen = Color(0xFF15803D);
  static const Color activeGreenBg = Color(0xFFDCFCE7);
  static const Color warningOrange = Color(0xFFC2410C);
  static const Color warningOrangeBg = Color(0xFFFFEDD5);
  static const Color infoBlue = Color(0xFF1D4ED8);
  static const Color infoBlueBg = Color(0xFFDBEAFE);
  static const Color dangerRed = Color(0xFFB91C1C);
  static const Color dangerRedBg = Color(0xFFFEE2E2);
}

class AppConstants {
  static const String appName = 'ParaliSetu';
  static const String tagline = 'Crop residue, put to work.';

  static const List<String> cropTypes = [
    'Rice straw',
    'Wheat straw',
    'Maize stalks',
    'Sugarcane trash',
    'Cotton stalks',
  ];

  static const List<String> commonDistricts = [
    'Ludhiana',
    'Patiala',
    'Sangrur',
    'Bathinda',
    'Amritsar',
    'Jalandhar',
    'Firozpur',
    'Mansa',
  ];
}
