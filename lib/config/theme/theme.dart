import 'package:flutter/material.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';

final themeData = ThemeData(
  scaffoldBackgroundColor: ColorName.backgroundColor,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: ColorName.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: ColorName.white,
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
    titleSmall: TextStyle(
      color: ColorName.white,
      fontSize: 15,
      fontWeight: FontWeight.w200,
    ),
  ),
);
