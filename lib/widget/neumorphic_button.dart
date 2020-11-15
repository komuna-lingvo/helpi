import 'package:flutter/material.dart';
import 'package:helpi/widget/neumorphic_widget.dart';

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
    ThemeData _theme = Theme.of(context);
    MediaQueryData _mediaQueryData = MediaQuery.of(context);

    Orientation _orientation = _mediaQueryData.orientation;
    TextStyle _textStyle = _theme.textTheme.headline1
        .copyWith(
          fontSize: 104.0,
          color: _theme.primaryColor,
        )
        .apply(
          fontSizeFactor: _orientation == Orientation.portrait ? 1 : .75,
        );

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
            child:
                Text(this.text, style: _textStyle, textAlign: TextAlign.center),
          ),
          decoration: BoxDecoration(shape: this.shape ?? BoxShape.circle),
        ),
      ),
    );
  }
}
