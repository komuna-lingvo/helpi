import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/data/model/contact.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:helpi/data/service/contacts_service.dart';
import 'package:helpi/data/service/notifications_service.dart';
import 'package:helpi/util/min_length_text_field.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class AddButtonController extends GetxController {
  var _logger = new Logger();

  final ButtonRepository repository;
  final AppContactsService contactsService;
  final NotificationsService notificationsService;

  AddButtonController({
    @required this.repository,
    @required this.contactsService,
    @required this.notificationsService,
  });

  MinLengthTextField _minLengthTextField;

  final int _textMinLength = 3;
  final Set<String> _uniquePhoneNumbers = new LinkedHashSet();

  final int textMaxLength = 30;
  final int maxContacts = 5;
  final TextEditingController titleTextController = TextEditingController();
  final RxList<Contact> contacts = RxList();
  final RxBool isSubmitDisable = true.obs;
  final RxBool isAddContactDisable = false.obs;

  @override
  void onReady() {
    this._onWidgetBuild();
    super.onReady();
  }

  @override
  void onClose() {
    this.titleTextController.dispose();
    super.onClose();
  }

  Future<void> onAddContactPressed() async {
    try {
      Contact contact = await this.contactsService.addContactToDevice();

      this._addContact(contact);
    } on Exception {
      StackTrace.current;

      this
          .notificationsService
          .showSnackbar(Alert.ERROR, 'Permission to Contacts denied');
    }
  }

  Future<void> onAddContactsPressed() async {
    try {
      Contact contact = await this.contactsService.getContactFromDevice();

      this._addContact(contact);
    } on Exception {
      StackTrace.current;

      this
          .notificationsService
          .showSnackbar(Alert.ERROR, 'Permission to Contacts denied');
    }
  }

  void onRemoveContactPressed(int index) {
    this._uniquePhoneNumbers.remove(this.contacts[index].phoneNumber);
    this.contacts.removeAt(index);
    this.contacts.refresh();

    this.isAddContactDisable.value = this.contacts.length >= this.maxContacts;
  }

  Future<void> onAddButtonPressed() async {
    this.isSubmitDisable.value = true;

    Button button = new Button();
    button.title = this.titleTextController.value.text;

    try {
      await this.repository.saveHelpiButton(button, this.contacts.toList());

      Get.back();

      this
          .notificationsService
          .showSnackbar(Alert.SUCCESS, '"${button.title}" added!');
    } on DatabaseException catch (e) {
      StackTrace.current;
      this._logger.e('exception', e);

      if (e.isUniqueConstraintError()) {
        this
            .notificationsService
            .showSnackbar(Alert.ERROR, '"${button.title}" already exists!');

        return;
      }

      this.notificationsService.showSnackbar(
          Alert.ERROR, 'Ops!, "${button.title}" could not be saved!');
    } finally {
      this.isSubmitDisable.value = false;
    }
  }

  void _onWidgetBuild() {
    this._minLengthTextField = MinLengthTextField(
      controller: titleTextController,
      minLength: _textMinLength,
    );

    this._minLengthTextField.isValid.listen((value) {
      this.isSubmitDisable.value = value;
    });
  }

  void _addContact(Contact contact) {
    if (this.isAddContactDisable.value ||
        contact == null ||
        !_uniquePhoneNumbers.add(contact.phoneNumber)) {
      return;
    }

    this.contacts.add(contact);

    this.isAddContactDisable.value = this.contacts.length >= this.maxContacts;
  }
}
