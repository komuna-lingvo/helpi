import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpi/ui/theme/app_colors.dart';

final double _defaultIconSize = 32.0;
final double _defaultFontSize = 32.0;

class AppTheme {
  static TextTheme textTheme(TextTheme textTheme) =>
      GoogleFonts.quicksandTextTheme(textTheme).apply(
        bodyColor: AppColors.primaryTextColor,
        displayColor: AppColors.primaryTextColor,
      );

  static final ThemeData defaultTheme = ThemeData(
    appBarTheme: appBarTheme,
    iconTheme: _iconTheme,
    buttonTheme: _buttonTheme,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    popupMenuTheme: _popupMenuTheme,
    dialogTheme: _dialogTheme,
    primaryColor: AppColors.primaryColor,
    backgroundColor: AppColors.backgroundColor,
    errorColor: AppColors.errorColor,
    dividerColor: AppColors.listDividerColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.transparent,
    centerTitle: false,
    elevation: 0.0,
    actionsIconTheme: _iconTheme,
    iconTheme: _iconTheme,
  );
}

TextStyle _textStyle = GoogleFonts.quicksand(
  fontWeight: FontWeight.w300,
  fontSize: _defaultFontSize,
  color: AppColors.primaryTextColor,
);

IconThemeData _iconTheme = IconThemeData(
  size: _defaultIconSize,
  color: AppColors.primaryColor,
);

ButtonThemeData _buttonTheme = ButtonThemeData(
  buttonColor: AppColors.primaryColor,
  splashColor: AppColors.backgroundColor,
  disabledColor: AppColors.disabledPrimaryColor,
  focusColor: AppColors.darkPrimaryColor,
);

FloatingActionButtonThemeData _floatingActionButtonTheme =
    FloatingActionButtonThemeData(
  elevation: 8.0,
  disabledElevation: 4.0,
  focusElevation: 12.0,
  hoverElevation: 12.0,
  highlightElevation: 12.0,
  backgroundColor: AppColors.primaryColor,
  splashColor: AppColors.darkPrimaryColor,
  focusColor: AppColors.darkPrimaryColor,
  hoverColor: AppColors.darkPrimaryColor,
);

DialogTheme _dialogTheme = DialogTheme(
  contentTextStyle: _textStyle.apply(
    color: AppColors.primaryTextColor,
  ),
  titleTextStyle: _textStyle.copyWith(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w300,
    fontSize: _defaultFontSize - 8.0,
  ),
);

PopupMenuThemeData _popupMenuTheme = PopupMenuThemeData(
  color: AppColors.backgroundColor,
);
