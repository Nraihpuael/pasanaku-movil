import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pasanaku/config/config.dart';



const colorList = <Color>[
  Color(0xFFFDE047),
  Color(0xff4339B0),
  Color(0xFFF8F7F7),
]; 

const colorSeed = Color(0xff4339B0);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);


class AppTheme{
  final int selectedColor;
  
  AppTheme({
    this.selectedColor = 0
  });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme: AppBarTheme(
    color: colorList[0],
    titleTextStyle: GoogleFonts.montserratAlternates()
      .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: colorList[1] 
    ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorList[0],
      selectedItemColor: colorList[1],
      //elevation: 100 
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter()
        .copyWith( fontSize: 45, fontWeight: FontWeight.w900, color: colorSeed,  ),
      titleMedium: GoogleFonts.inter()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold ,color: colorSeed),
      titleSmall: GoogleFonts.inter()
        .copyWith( fontSize: 20, color: colorSeed )
    ),

    scaffoldBackgroundColor: scaffoldBackgroundColor,
    filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(
        GoogleFonts.montserratAlternates()
          .copyWith(fontWeight: FontWeight.w700)
        )
    )
  ),

  ///* AppBar
  
  );

  

}