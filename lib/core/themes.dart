import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO separate different variable so I can use from everywhere
class Themes {
  static final double _iconSize = 24.0;
  static final Color _backgroundColor = Colors.grey.shade200;
  static final Color _primaryColor = Colors.lightBlue.shade500;
  static final Color _textColor = Colors.grey.shade600;

  static ThemeData of(BuildContext context) {
    TextTheme _googleFontsTextTheme =
        GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme);
    TextStyle _googleFontsTexStyle = GoogleFonts.quicksand();

    IconThemeData _iconTheme = IconThemeData(
      size: _iconSize,
      color: _primaryColor,
    );

    ButtonThemeData _buttonTheme = ButtonThemeData(
      buttonColor: _primaryColor,
      splashColor: _backgroundColor,
    );

    FloatingActionButtonThemeData _floatingActionButtonTheme =
        FloatingActionButtonThemeData(
      elevation: 8.0,
      disabledElevation: 4.0,
      focusElevation: 12.0,
      hoverElevation: 12.0,
      highlightElevation: 12.0,
      backgroundColor: _primaryColor,
    );

    PopupMenuThemeData _popupMenuTheme = PopupMenuThemeData(
      color: _backgroundColor,
    );

    TextTheme _textTheme = _googleFontsTextTheme.apply(
      bodyColor: Colors.grey.shade800,
      displayColor: _textColor,
    );

    AppBarTheme _appBarTheme = AppBarTheme(
      color: Colors.transparent,
      centerTitle: false,
      elevation: 0.0,
      actionsIconTheme: _iconTheme,
      iconTheme: _iconTheme,
      textTheme: _textTheme,
    );

    DialogTheme _dialogTheme = DialogTheme(
      contentTextStyle: _googleFontsTexStyle.apply(
        color: Colors.grey.shade800,
      ),
      titleTextStyle: _googleFontsTexStyle.copyWith(
        color: _primaryColor,
        fontWeight: FontWeight.w400,
        fontSize: 24.0,
      ),
    );

    return ThemeData(
      appBarTheme: _appBarTheme,
      iconTheme: _iconTheme,
      buttonTheme: _buttonTheme,
      textTheme: _textTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      popupMenuTheme: _popupMenuTheme,
      dialogTheme: _dialogTheme,
      primaryColor: _primaryColor,
      backgroundColor: _backgroundColor,
      dividerColor: Colors.grey.shade400,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
