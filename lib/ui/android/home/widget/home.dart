import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/home_controller.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/widgets/helpi_button/helpi_button.dart';

class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    final double width = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.width
        : mediaQuery.size.width / 2;
    final double height = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.height / 2
        : mediaQuery.size.height;

    return Obx(() {
      if (this.controller.isLoading.value) {
        return CircularProgressIndicator();
      }

      List<Button> buttons = this.controller.buttons;

      if (buttons.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/empty_buttons.svg',
              width: width,
              height: height,
              // semanticsLabel: 'A man looking to clear sky with full moon',
            ),
            AutoSizeText(
              "You don't have any button.\nTry add one.",
              textAlign: TextAlign.center,
              minFontSize: 24.0,
            ),
          ],
        );
      }

      return ListView.builder(
        itemCount: buttons.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Button button = buttons[index];

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: HelpiButton(
              button,
              disabled: !this.controller.isAvailable.value,
            ),
          );
        },
      );
    });
  }
}
