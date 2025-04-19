import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

class CustomFonts {
  static var arFonts = GoogleFonts.rubik().fontFamily;
  static var enFonts = GoogleFonts.poppins().fontFamily;
  static TextDirection getTextDirection(Locale locale) {
    if (locale.languageCode == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }
}
