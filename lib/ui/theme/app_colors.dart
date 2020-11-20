import 'package:flutter/material.dart';

class AppColors {
  static final Color backgroundColor = Color.fromRGBO(242, 242, 242, 1);
  static final Color errorColor = Colors.redAccent.shade400;

  static final Color listDividerColor = primaryColor;

  static final Color primaryColor = Color.fromRGBO(86, 204, 242, 1);
  static final Color darkPrimaryColor = primaryColor.withRed(106);
  static final Color disabledPrimaryColor = primaryColor.withOpacity(0.5);

  static final Color primaryTextColor = Colors.grey.shade600;
  static final Color buttonTextColor = backgroundColor;
}
