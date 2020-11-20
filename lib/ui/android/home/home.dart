import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/home_controller.dart';
import 'package:helpi/ui/android/add_button/add_button.dart';
import 'package:helpi/ui/android/home/widget/home.dart';
import 'package:helpi/ui/theme/app_colors.dart';
import 'package:helpi/widgets/notification_dialog.dart';
import 'package:helpi/widgets/secondary_button.dart';

class HomeScreen extends GetView<HomeController> {
  static const String ROUTE = 'home';

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen...');
    TextStyle dialogContentTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryColor,
    );

    NotificationDialog dialog = NotificationDialog(
      content: Text(
        'Tap once to edit your button.\nTap and hold to send the alert.',
        style: dialogContentTextStyle,
      ),
      actions: [
        SecondaryButton(
          child: Text('Got it!'),
          onPressed: () => Get.back(),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            color: AppColors.primaryColor,
            onPressed: () => Get.dialog(
              dialog,
              barrierColor: Color.fromRGBO(38, 47, 86, 0.5),
              useSafeArea: true,
              barrierDismissible: true,
            ),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: AppColors.primaryColor,
            // onPressed: Get.toNamed(SettingsScreen.ROUTE), // TODO
            onPressed: null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add a button'),
        icon: Icon(Icons.add_circle),
        tooltip: 'Add a button',
        onPressed: () => Get.toNamed(AddButtonScreen.ROUTE),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(height: 64.0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(child: Center(child: Home())),
        ),
      ),
    );
  }
}
