import 'package:flutter/material.dart';
import 'package:helpi/core/model/button.dart';
import 'package:helpi/widgets/neumorphic_button.dart';
import 'package:telephony/telephony.dart';

class HelpiButton extends StatelessWidget {
  final Button helpi;
  final bool disabled;

  const HelpiButton(this.helpi, {this.disabled = false});

  // TODO state
  final bool _isDisabled = false;

  void _onHelpiButtonPressed() async {
    print("helpi button pressed");
    // _isDisabled = true;

    try {
      // TODO if phoneNumbers empty disable
      // TODO verify permission. HOME PAGE. if not set disabled
      // TODO make sure 160 characters
      final Telephony telephony = Telephony.instance; // TODO move up
      // for (String phoneNumber in this.helpi.phoneNumbers) {
      //   final SmsSendStatusListener smsSendStatusListener =
      //       (SendStatus status) {
      //     switch (status) {
      //       case SendStatus.SENT:
      //       case SendStatus.DELIVERED:
      //         print("message to $phoneNumber ${status.toString()}");
      //         Get.snackbar("${helpi.title} triggered", "Message sent");
      //         break;
      //       default:
      //         print("message to $phoneNumber queued");
      //         break;
      //     }
      //   };
      //
      //   telephony.sendSms(
      //     to: phoneNumber,
      //     statusListener: smsSendStatusListener,
      //     message: "hello world",
      //   ); // TODO
      // }
    } on Exception catch (e) {
      print(e);
      // _isDisabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      this.helpi.title,
      onPressed: !this.disabled ? () => this._onHelpiButtonPressed() : null,
    );
  }
}
