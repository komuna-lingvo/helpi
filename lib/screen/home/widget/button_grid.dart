import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:helpi/core/model/button.dart';
import 'package:helpi/screen/home/controller/button_grid_controller.dart';
import 'package:helpi/screen/home/widget/helpi_button.dart';

class ButtonGrid extends GetView<ButtonGridController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (this.controller.isLoading.value) {
        return CircularProgressIndicator();
      }

      List<Button> buttons = this.controller.buttons;

      if (buttons.isEmpty) {
        return SvgPicture.asset(
          'assets/empty_buttons.svg',
          height: 150,
          width: 150,
          // semanticsLabel: 'A man looking to clear sky with full moon',
        );
      }

      return ListView.builder(
        itemCount: buttons.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Button button = buttons[index];
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: HelpiButton(button),
          );
        },
      );
    });
  }
}
