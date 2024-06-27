import 'package:flutter/material.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/gen/fonts.gen.dart';

final themeData = ThemeData(
  scaffoldBackgroundColor: ColorName.backgroundColor,
  fontFamily: FontFamily.montserrat,
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
