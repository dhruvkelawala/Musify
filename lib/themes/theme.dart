import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

final ThemeData appTheme = ThemeData(
  canvasColor: Hexcolor("#0D101B"),
  backgroundColor: Color(0xff0D101B),
  brightness: Brightness.dark,
  primaryColor: Hexcolor("#8694FF"),
  accentColor: Colors.white,
  fontFamily: GoogleFonts.ptSans().fontFamily,
  // textTheme: TextTheme()
);
