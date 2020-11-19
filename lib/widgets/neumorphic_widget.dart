import 'package:flutter/material.dart';
import 'package:helpi/core/decorations.dart';

class NeumorphicWidget extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final BoxShape shape;
  final bool disabled;
  final bool mini;
  final VoidCallback onPressed;

  const NeumorphicWidget({
    @required this.child,
    this.width,
    this.height,
    this.shape = BoxShape.circle,
    this.disabled = false,
    this.mini = false,
    this.onPressed,
  });

  @override
  _NeumorphicWidgetState createState() => _NeumorphicWidgetState();
}

class _NeumorphicWidgetState extends State<NeumorphicWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    print('Building NeumorphicWidget...');
    final ThemeData _theme = Theme.of(context);
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);

    const double concaveDecorationDepth = 30.0;
    const double buttonRadius = 12.0;

    final Size _size = _mediaQueryData.size;
    final Orientation _orientation = _mediaQueryData.orientation;
    final Color _shadowColor = Colors.grey.shade300;
    final Color _lightColor = Colors.white70;
    final double _blurRadius =
        this.widget.mini ? buttonRadius / 3 : buttonRadius;
    final double _spreadRadius = _blurRadius / 2.0;
    final double _buttonOffset =
        this.widget.mini ? buttonRadius / 3 : buttonRadius;
    final Offset _shadowOffset = Offset(_buttonOffset, _buttonOffset);
    final Offset _lightOffset = -Offset(_buttonOffset, _buttonOffset);
    final bool _isPortrait = _orientation == Orientation.portrait;
    final double _defaultWidth = _isPortrait ? _size.width : _size.width / 2;
    final double _defaultHeight = _isPortrait ? _size.height / 2 : _size.width;

    final _innerShadowDecoration = ConcaveDecoration(
      shape: CircleBorder(),
      depth: concaveDecorationDepth,
      colors: [_lightColor, Colors.grey.shade400],
    );

    final _outerShadowDecoration = BoxDecoration(
      border: Border.all(color: _theme.backgroundColor),
      color: _theme.backgroundColor,
      shape: this.widget.shape,
      boxShadow: [
        BoxShadow(
          color: _lightColor,
          offset: _lightOffset,
          blurRadius: _blurRadius,
          spreadRadius: _spreadRadius,
        ),
        BoxShadow(
          color: _shadowColor,
          offset: _shadowOffset,
          blurRadius: _blurRadius,
          spreadRadius: _spreadRadius,
        ),
      ],
    );

    void _onTapUpGesture(TapUpDetails tapUpDetails) {
      setState(() {
        this._isPressed = false;
        print('_isPressed ${this._isPressed}');
      });
    }

    void _onTapDownGesture(TapDownDetails tapUpDetails) {
      setState(() {
        this._isPressed = true;
        print('_isPressed ${this._isPressed}');
      });
    }

    void _onLongPressEndGesture(LongPressEndDetails longPressEndDetails) {
      setState(() {
        this._isPressed = false;
        print('_isPressed ${this._isPressed}');
      });
    }

    return GestureDetector(
      onTapUp: _onTapUpGesture,
      onTapDown: _onTapDownGesture,
      onLongPressEnd: _onLongPressEndGesture,
      onTap: this.widget.onPressed,
      child: Container(
        width: this.widget.width ?? _defaultWidth,
        height: this.widget.height ?? _defaultHeight,
        decoration: this.widget.disabled || this._isPressed
            ? _innerShadowDecoration
            : _outerShadowDecoration,
        child: this.widget.child,
      ),
    );
  }
}
