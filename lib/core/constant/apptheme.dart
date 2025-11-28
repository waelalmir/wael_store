import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';

ThemeData themeEn = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: AppColor.textcolor),
    backgroundColor: AppColor.primeColor,
  ),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: AppColor.primeColor),
  fontFamily: "Montserrat",
  textTheme: const TextTheme(
      headlineLarge: TextStyle(),
      displayLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: AppColor.primeColor),
      displayMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
      bodyLarge: TextStyle(
          height: 2,
          color: AppColor.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14),
      bodyMedium: TextStyle(height: 2, color: AppColor.grey, fontSize: 14)),
  primarySwatch: Colors.blue,
);
ThemeData themeAr = ThemeData(
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: AppColor.primeColor),
  fontFamily: "Cairo",
  textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: AppColor.primeColor),
      displayMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
      bodyLarge: TextStyle(
          height: 2,
          color: AppColor.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14),
      bodyMedium: TextStyle(height: 2, color: AppColor.grey, fontSize: 14)),
  primarySwatch: Colors.blue,
);
