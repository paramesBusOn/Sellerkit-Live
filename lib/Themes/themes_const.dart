// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../Constant/colorGenarator.dart';
import '../Constant/colorpalates.dart';

ThemeData merronTheme(BuildContext context) {
  return ThemeData(
    useMaterial3:false,
    brightness: Brightness.light,
    primaryColor:Palettes.primary,
    primarySwatch: generateMaterialColor(Palettes.primary),
    fontFamily: 'HelveticaNow',//HelveticaNow,SEGOEUIL,ayar,Ordina-WideThin,Celias-Medium*,
    //TruenoRound
    //Quicksand_Bold_Oblique,NovaRegular,Sabon*,OpenSans-Regular
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white
      //  foregroundColor: Colors.red,
    ),

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'Segoe')))),

    // textTheme: TextTheme(
    //   headline3: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline1: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline2: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline4: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline5: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline6: TextStyle(fontFamily: 'SEGOEUIL'),
    //   bodyText1: TextStyle(
    //     fontFamily: 'SEGOEUIL',
    //   ),
    //   bodyText2: TextStyle(fontFamily: 'SEGOEUIL'),
    //   subtitle1: TextStyle(fontFamily: 'SEGOEUIL'),
    //   subtitle2: TextStyle(fontFamily: 'SEGOEUIL'),
    // ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary),
      ),
    ),

    iconTheme: IconThemeData(color: Colors.white),

  );
}

//

ThemeData blueTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary2,
    primarySwatch: generateMaterialColor(Palettes.primary2),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white
      //  foregroundColor: Colors.red,
    ),

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary2.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'Segoe')))),

    textTheme: TextTheme(
      headline3: TextStyle(fontFamily: 'Segoe'),
      headline1: TextStyle(fontFamily: 'Segoe'),
      headline2: TextStyle(fontFamily: 'Segoe'),
      headline4: TextStyle(fontFamily: 'Segoe'),
      headline5: TextStyle(fontFamily: 'Segoe'),
      headline6: TextStyle(fontFamily: 'Segoe'),
      bodyText1: TextStyle(
        fontFamily: 'Segoe',
      ),
      bodyText2: TextStyle(fontFamily: 'Segoe'),
      subtitle1: TextStyle(fontFamily: 'Segoe'),
      subtitle2: TextStyle(fontFamily: 'Segoe'),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary2),
      ),
    ),

    iconTheme: IconThemeData(color: Colors.white),

  );
}

//orange

ThemeData orangeTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary3,
    primarySwatch: generateMaterialColor(Palettes.primary3),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white
      //  foregroundColor: Colors.red,
    ),

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary3),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary3.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'Segoe')))),

    textTheme: TextTheme(
      headline3: TextStyle(fontFamily: 'Segoe'),
      headline1: TextStyle(fontFamily: 'Segoe'),
      headline2: TextStyle(fontFamily: 'Segoe'),
      headline4: TextStyle(fontFamily: 'Segoe'),
      headline5: TextStyle(fontFamily: 'Segoe'),
      headline6: TextStyle(fontFamily: 'Segoe'),
      bodyText1: TextStyle(
        fontFamily: 'Segoe',
      ),
      bodyText2: TextStyle(fontFamily: 'Segoe'),
      subtitle1: TextStyle(fontFamily: 'Segoe'),
      subtitle2: TextStyle(fontFamily: 'Segoe'),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary3),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary3),
      ),
    ),

    iconTheme: IconThemeData(color: Colors.white),

  );
}

//DARK
ThemeData darkTheme (BuildContext context){
  return
  ThemeData(
    brightness: Brightness.dark,
    primarySwatch: generateMaterialColor(Palettes.primary),
    primaryColorDark:
        Palettes.primary, //generateMaterialColor(Palette.primary),
    primaryColor: Palettes.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: Palettes.primary,
      // foregroundColor: Colors.red,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(
              vertical: 10,
            ) //horizontal: 30
                ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(Palettes.primary),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            // overlayColor:  MaterialStateProperty.all<Color>(Colors.black26),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'Segoe')))),
    textTheme: TextTheme(
      headline3: TextStyle(fontFamily: 'Segoe'),
      headline1: TextStyle(fontFamily: 'Segoe'),
      headline2: TextStyle(fontFamily: 'Segoe'),
      headline4: TextStyle(fontFamily: 'Segoe'),
      headline5: TextStyle(fontFamily: 'Segoe'),
      headline6: TextStyle(fontFamily: 'Segoe'),
      bodyText1: TextStyle(fontFamily: 'Segoe'),
      bodyText2: TextStyle(fontFamily: 'Segoe'),
      subtitle1: TextStyle(fontFamily: 'Segoe'),
      subtitle2: TextStyle(fontFamily: 'Segoe'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary),
      ),
    ),
    switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all<Color>(Colors.grey),
        thumbColor: MaterialStateProperty.all<Color>(Colors.white)),
    primaryIconTheme: IconThemeData(color: Colors.amber),
    iconTheme: IconThemeData(color: Colors.white));
}