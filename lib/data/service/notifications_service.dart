import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/ui/theme/app_colors.dart';
import 'package:logger/logger.dart';

class NotificationsService extends GetxService {
  var _logger = Logger();

  void showSnackbar(Alert alert, String message) {
    this._logger.d("snackbar message", message);

    String title = alert == Alert.ERROR
        ? 'Oh no!'
        : alert == Alert.SUCCESS
            ? 'Great!'
            : 'Message!';

    SnackPosition position =
        alert == Alert.ERROR ? SnackPosition.TOP : SnackPosition.BOTTOM;
    Color backgroundColor = alert == Alert.ERROR
        ? Colors.redAccent.shade200
        : alert == Alert.SUCCESS
            ? Colors.greenAccent.shade400
            : Colors.blueGrey.shade400;

    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: AppColors.buttonTextColor,
      isDismissible: true,
      duration: Duration(seconds: 3),
    );
  }
}

enum Alert { INFO, SUCCESS, ERROR }
