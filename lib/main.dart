import 'package:flutter/material.dart';
import 'package:nike/screen/home/home_screen.dart';
import 'package:nike/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeMetod(),
        home: const Directionality(
            textDirection: TextDirection.rtl, child: HomeScreen()));
  }

//! theme
  ThemeData themeMetod() {
    const defaultTextStyle = TextStyle(
        fontFamily: 'yekan', color: LightThemeColors.primaryTextColor);
    return ThemeData(
        textTheme: TextTheme(
            bodyMedium: defaultTextStyle,
            bodySmall: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            //headline6
            titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.red,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: LightThemeColors.secondaryColor,
          foregroundColor: LightThemeColors.secondaryTextColor,
        ));
  }
}
