import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextStyle primaryHeaderText(
      BuildContext context, Color color, double size) {
    return GoogleFonts.poppinsTextTheme().headline1!.copyWith(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w700,
        );
  }

  static TextStyle primaryBodyText(
      BuildContext context, Color color, double size) {
    return GoogleFonts.poppinsTextTheme().headline1!.copyWith(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w400,
        );
  }
}
