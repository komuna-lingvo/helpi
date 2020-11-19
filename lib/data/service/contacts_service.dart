import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpi/data/model/contact.dart' as app;
import 'package:helpi/data/service/notifications_service.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class AppContactsService extends GetxService {
  var _logger = Logger();

  NotificationsService notificationsService;

  AppContactsService({
    @required this.notificationsService,
  });

  Future<app.Contact> addContactToDevice() {
    return this._builder(() => ContactsService.openContactForm());
  }

  Future<app.Contact> getContactFromDevice() async {
    return this._builder(() => ContactsService.openDeviceContactPicker());
  }

  Future<app.Contact> _builder(Future<Contact> f()) async {
    try {
      PermissionStatus permissionStatus = await Permission.contacts.request();

      if (!permissionStatus.isGranted) {
        throw ('permission denied to read contacts');
      }

      Contact contact = await f();

      app.Contact model = app.Contact();
      model.name = contact.displayName;

      if (!this._hasMobilePhoneNumber(contact)) {
        return null;
      }

      model.phoneNumber = contact.phones.elementAt(0).value;

      this._logger.d('contact', contact.toString());

      return model;
    } on FormOperationException catch (e) {
      switch (e.errorCode) {
        case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
          this
              .notificationsService
              .showSnackbar(Alert.ERROR, "Contacts app could not be opened");
          break;
        case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
          this.notificationsService.showSnackbar(Alert.ERROR, "Unknown error");
          break;
        default:
          this._logger.d("Operation cancelled");
          break;
      }
    }

    return null;
  }

  bool Function(Contact contact) _hasMobilePhoneNumber = (Contact contact) =>
      contact.phones
          .toList()
          .map((phone) => phone.label.toLowerCase())
          .contains("mobile");
}
