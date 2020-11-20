import 'package:flutter/material.dart';
import 'package:helpi/ui/theme/app_colors.dart';

class NotificationDialog extends StatelessWidget {
  final IconData icon;
  final Widget content;
  final List<Widget> actions;

  NotificationDialog({
    this.icon = Icons.info_outline,
    @required this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final double iconNotificationContainerWidth = 128.0;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColors.primaryColor,
            height: iconNotificationContainerWidth,
            child: Center(
              child: Icon(
                this.icon,
                size: iconNotificationContainerWidth * 0.75,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: this.content,
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: this.actions,
            ),
          ),
        ],
      ),
    );
  }
}
