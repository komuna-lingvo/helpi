import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/widgets/helpi_button/controller.dart';
import 'package:helpi/widgets/neumorphic_button.dart';

class HelpiButton extends GetView<HelpiButtonController> {
  final Button button;
  final bool disabled;

  const HelpiButton(this.button, {this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      this.button.title,
      onPressed: !this.disabled
          ? () => this.controller.onHelpiButtonPressed(button)
          : null,
    );
  }
}
