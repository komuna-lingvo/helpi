import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:helpi/widgets/neumorphic_widget.dart';

class NeumorphicButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final BoxShape shape;

  const NeumorphicButton(
    this.text, {
    @required this.onPressed,
    this.width,
    this.height,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    print('Building NeumorphicButton...');

    return Container(
      width: this.width,
      height: this.height,
      child: NeumorphicWidget(
        width: this.width,
        height: this.height,
        disabled: this.onPressed == null,
        onPressed: this.onPressed,
        child: Container(
          child: Center(
            child: AutoSizeText(
              this.text.toUpperCase(),
              minFontSize: 40.0,
              textAlign: TextAlign.center,
            ),
          ),
          decoration: BoxDecoration(shape: this.shape ?? BoxShape.circle),
        ),
      ),
    );
  }
}
