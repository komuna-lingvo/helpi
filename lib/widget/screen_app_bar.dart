import 'package:flutter/material.dart';

class ScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget subtitle;
  final bool showBackButton;
  final VoidCallback onBackButtonPressed;
  final List<Widget> actions;

  const ScreenAppBar({
    this.title,
    this.subtitle,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.actions,
  }) : assert(showBackButton && onBackButtonPressed != null);

  @override
  Size get preferredSize =>
      Size.fromHeight(64.0 * (this.title == null ? 1 : 2));

  @override
  Widget build(BuildContext context) {
    print('Building ScreenAppBar...');

    return AppBar(
      title: this.subtitle,
      automaticallyImplyLeading: this.showBackButton,
      leading: this.showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => this.onBackButtonPressed(),
            )
          : null,
      actions: this.actions,
      bottom: PreferredSize(
        preferredSize: this.preferredSize,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: this.title,
          ),
        ),
      ),
    );
  }
}
