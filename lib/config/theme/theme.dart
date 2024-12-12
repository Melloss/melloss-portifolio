import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';

final themeData = ThemeData(
  scaffoldBackgroundColor: ColorName.backgroundColor,
  fontFamily: GoogleFonts.firaCode().fontFamily,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    primary: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: const Color(0xFFA8A6A8).withOpacity(0.5),
    filled: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    collapsedBackgroundColor: Colors.transparent,
    collapsedShape: InputBorder.none,
    collapsedTextColor: Colors.white,
    textColor: Colors.white,
    iconColor: Colors.white,
    collapsedIconColor: Colors.white,
    backgroundColor: ColorName.white.withOpacity(0.1),
  ),
  sliderTheme: const SliderThemeData(
      activeTrackColor: ColorName.primaryColor,
      trackHeight: 3,
      rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 5)),
  popupMenuTheme: PopupMenuThemeData(
    shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.white24,
          width: 1,
        )),
    surfaceTintColor: ColorName.forgroundColor,
    color: ColorName.forgroundColor,
    elevation: 20,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: ColorName.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: ColorName.white,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: ColorName.white,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
  ),
);
