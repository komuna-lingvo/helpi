import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/data/model/contact.dart';
import 'package:helpi/data/repository/database.dart';
import 'package:logger/logger.dart';

class ButtonRepository extends GetxService {
  var _logger = Logger();

  final AppDatabase database;

  ButtonRepository({@required this.database});

  Future<List<Button>> getAllButtons() async {
    List<Button> buttons = <Button>[];

    try {
      var instance = await this.database.instance;

      final List<Map<String, dynamic>> results =
          await instance.query(AppDatabase.TABLE_BUTTONS);

      this._logger.d('results: ${results.length}');

      results.forEach((element) {
        buttons.add(Button.fromJson(element));
      });

      return buttons;
    } on Exception {
      StackTrace.current;
    }

    return buttons;
  }

  Future<List<Contact>> getAllContacts(int id) async {
    List<Contact> contacts = <Contact>[];

    try {
      var instance = await this.database.instance;

      final List<Map<String, dynamic>> results = await instance.rawQuery(
          'SELECT * FROM ${AppDatabase.TABLE_CONTACTS} WHERE buttonId = ?',
          [id]);

      this._logger.d('results: ${results.length}');

      results.forEach((element) {
        contacts.add(Contact.fromJson(element));
      });

      return contacts;
    } on Exception {
      StackTrace.current;
    }

    return contacts;
  }

  Future<void> saveHelpiButton(Button button, List<Contact> contacts) async {
    var instance = await this.database.instance;

    return instance.transaction((txn) async {
      int id = await txn.insert(AppDatabase.TABLE_BUTTONS, button.toMap());

      contacts.forEach((contact) async {
        contact.buttonId = id;

        await txn.insert(AppDatabase.TABLE_CONTACTS, contact.toMap());
      });
    });
  }

  Future<void> updateHelpiButton(Button button) async {
    var instance = await this.database.instance;

    if (button.id == null) {
      throw ("button must have an id");
    }

    return instance.update(
      AppDatabase.TABLE_BUTTONS,
      button.toMap(),
      where: 'id = ?',
      whereArgs: [button.id],
    );
  }
}
