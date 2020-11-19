import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/data/model/contact.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:logger/logger.dart';
import 'package:telephony/telephony.dart';

class HelpiButtonController extends GetxController {
  var _logger = Logger();

  final ButtonRepository repository;

  HelpiButtonController({@required this.repository});

  final Telephony _telephony = Telephony.instance;

  void onHelpiButtonPressed(Button button) async {
    try {
      List<Contact> contacts = await this.repository.getAllContacts(button.id);

      if (contacts.isEmpty) {
        return;
      }

      String message = this._helpiMessage;

      for (Contact contact in contacts) {
        this._sendSMS(contact.phoneNumber, message);
      }
    } on Exception {
      StackTrace.current;
    }
  }

  void _sendSMS(String phoneNumber, String message) {
    final SmsSendStatusListener smsSendStatusListener = (SendStatus status) {
      switch (status) {
        case SendStatus.SENT:
        case SendStatus.DELIVERED:
          this._logger.d("message to $phoneNumber ${status.toString()}");
          // Get.snackbar("${helpi.title} triggered", "Message sent");
          break;
        default:
          this._logger.d("message to $phoneNumber queued");
          break;
      }
    };

    _telephony.sendSms(
      to: phoneNumber,
      statusListener: smsSendStatusListener,
      message: message,
    );
  }

  // TODO make sure 160 characters
  String get _helpiMessage {
    return null;
  }
}
