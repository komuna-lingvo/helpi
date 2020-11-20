import 'package:flutter/material.dart';
import 'package:helpi/ui/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  SecondaryButton({
    this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: this.child,
      textColor: AppColors.primaryColor,
      disabledTextColor: AppColors.disabledPrimaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.primaryColor,
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      onPressed: this.onPressed,
    );
  }
}
