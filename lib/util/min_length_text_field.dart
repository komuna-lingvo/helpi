import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinLengthTextField {
  final String text;
  final int minLength;
  final TextEditingController controller;

  MinLengthTextField({
    this.text,
    this.minLength = 3,
    this.controller,
  }) {
    this.controller.addListener(textHasMinLengthListener);
    this.controller.text = this.text;
  }

  RxBool isValid = true.obs;

  void textHasMinLengthListener() {
    if (this.controller.text.length < this.minLength) {
      return;
    }

    this.isValid.value = false;
    this.controller.removeListener(textHasMinLengthListener);
    this.controller.addListener(textRequireMinLengthListener);
  }

  void textRequireMinLengthListener() {
    if (this.controller.text.length >= this.minLength) {
      return;
    }

    this.isValid.value = true;
    this.controller.addListener(textHasMinLengthListener);
    this.controller.removeListener(textRequireMinLengthListener);
  }
}
