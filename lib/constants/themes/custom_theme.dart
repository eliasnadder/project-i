import 'package:flutter/material.dart';
import 'package:example1/constants/fonts/custom_fonts.dart';

/// Light mode colors
class AppColors {
  static const Color primary = Color(0xFF003366); // Deep Blue
  //Usage: App bar, main buttons, or logo backgrounds for a strong, reliable feel.

  static const Color accent = Color(0xFF87CEEB); // Sky Blue
  //Usage: Highlights, icons, and interactive elements to add a fresh, airy vibe.

  static const Color background = Color(0xFFF4A460); // Sand
  //Usage: Screen backgrounds or cards to evoke warm, earthy travel tones.

  static const Color action = Color(0xFFFF7F50); // Coral
  //Usage: Call-to-action buttons or notifications, offering a vibrant pop.

  static const Color secondary = Color(0xFF98FF98); // Mint
  //Usage: Secondary buttons or subtle accents that provide a calming contrast.

  static const Color highlight = Color(0xFFFFD700); // Sun Yellow
  //Usage: Badges, highlights, or special promotions to draw attention.

  static const Color ecoGreen = Color(0xFF228B22); // Earth Green
  //Usage: Elements related to nature or eco-friendly features of the app.

  static ThemeData lightTheme(BuildContext context, Locale locale) {
    final String? fontFamily =
        locale.languageCode == 'ar' ? CustomFonts.arFonts : CustomFonts.enFonts;

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      hintColor: AppColors.accent,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: fontFamily,
          fontSize: 20,
        ),
      ),
      buttonTheme: ButtonThemeData(buttonColor: AppColors.action),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontFamily: fontFamily),
        bodyMedium: TextStyle(color: Colors.black, fontFamily: fontFamily),
      ),
    );
  }
}

/// Dark mode colors
class DarkModeColors {
  static const Color primary = Color(0xFF121212); // Dark Background
  //Usage: Main background color for screens, providing a deep, dark base.

  static const Color accent = Color(0xFF00B0FF); // Electric Blue
  //Usage: Highlights and interactive elements such as icons or buttons to stand out against the dark background.

  static const Color secondary = Color(0xFF3700B3); // Deep Purple
  //Usage: Secondary buttons, borders, or subtle accents to complement the primary dark tone.

  static const Color action = Color(0xFFFF6D00); // Vivid Orange
  //Usage: Call-to-action buttons and notifications, offering a warm, energetic contrast.

  static const Color highlight = Color(0xFFFFC107); // Amber
  //Usage: Badges, notifications, or special promotions for drawing attention.

  static const Color ecoGreen = Color(0xFF76FF03); // Lime Green
  //Usage: Elements related to eco-friendly features, providing a fresh pop of color.

  static const Color backgroundAccent = Color(0xFF1E1E1E); // Charcoal Gray
  //Usage: For cards, modal backgrounds, or secondary sections to create subtle layering.

  static ThemeData darkTheme(BuildContext context, Locale locale) {
    final String? fontFamily =
        locale.languageCode == 'ar' ? CustomFonts.arFonts : CustomFonts.enFonts;
    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.dark,
      primaryColor: DarkModeColors.primary,
      hintColor: DarkModeColors.accent,
      scaffoldBackgroundColor: DarkModeColors.primary,
      canvasColor: DarkModeColors.backgroundAccent,
      appBarTheme: AppBarTheme(
        color: DarkModeColors.primary,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
          fontSize: 20,
        ),
      ),
      buttonTheme: ButtonThemeData(buttonColor: DarkModeColors.action),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontFamily: fontFamily),
        bodyMedium: TextStyle(color: Colors.white, fontFamily: fontFamily),
      ),
    );
  }
}
