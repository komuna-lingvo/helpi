import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/add_button_controller.dart';
import 'package:helpi/data/model/contact.dart';
import 'package:helpi/ui/theme/app_colors.dart';
import 'package:helpi/widgets/secondary_button.dart';

class AddButton extends GetView<AddButtonController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          style: TextStyle(color: AppColors.primaryColor),
          controller: this.controller.titleTextController,
          decoration: InputDecoration(
            hintText: 'My Helpi Button',
          ),
          autocorrect: false,
          enableSuggestions: false,
          maxLength: this.controller.textMaxLength,
          maxLengthEnforced: true,
        ),
        Obx(() {
          return SecondaryButton(
            child: AutoSizeText(
              'Add contact (Max. ${this.controller.maxContacts})',
              minFontSize: 16.0,
            ),
            onPressed: this.controller.isAddContactDisable.value
                ? null
                : this.controller.onAddContactsPressed,
          );
        }),
        Expanded(
          child: Obx(() {
            return ListView.separated(
              separatorBuilder: (BuildContext context, _) => Divider(
                thickness: 1.0,
                indent: 64.0,
              ),
              shrinkWrap: true,
              itemCount: this.controller.contacts.length,
              itemBuilder: (context, index) {
                Contact contact = this.controller.contacts[index];

                return ListTile(
                  key: Key((contact.id ?? index).toString()),
                  dense: true,
                  leading: Container(
                    width: 40.0,
                    height: 40.0,
                    child: Center(
                        child:
                            Text(contact.name.toUpperCase().substring(0, 2))),
                    decoration: ShapeDecoration(
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.phoneNumber),
                  trailing: IconButton(
                    icon: Icon(Icons.person_remove),
                    color: Colors.blue,
                    onPressed: () =>
                        this.controller.onRemoveContactPressed(index),
                  ),
                );
              },
            );
          }),
        ),
        Obx(() {
          return Container(
            height: 48.0,
            child: RaisedButton(
              elevation: 16.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: AutoSizeText('Add'.toUpperCase(), minFontSize: 24.0),
              textColor: AppColors.buttonTextColor,
              disabledTextColor: AppColors.buttonTextColor,
              onPressed: this.controller.isSubmitDisable.value ||
                      this.controller.contacts.isEmpty
                  ? null
                  : this.controller.onAddButtonPressed,
            ),
          );
        })
      ],
    );
  }
}
