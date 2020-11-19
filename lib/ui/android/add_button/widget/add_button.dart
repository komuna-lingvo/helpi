import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/add_button_controller.dart';
import 'package:helpi/data/model/contact.dart';
import 'package:helpi/ui/theme/app_colors.dart';

class AddButton extends GetView<AddButtonController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: this.controller.titleTextController,
          decoration: InputDecoration(hintText: 'My Helpi Button'),
          autocorrect: false,
          enableSuggestions: false,
          maxLength: this.controller.textMaxLength,
          maxLengthEnforced: true,
        ),
        Obx(() {
          return FlatButton(
            child: Text('Add contact (Max. ${this.controller.maxContacts})'),
            textColor: AppColors.primaryColor,
            disabledTextColor: AppColors.disabledPrimaryColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.primaryColor,
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(64.0),
            ),
            onPressed: this.controller.isAddContactDisable.value
                ? null
                : this.controller.onAddContactsPressed,
          );
        }),
        Expanded(
          child: Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: this.controller.contacts.length,
              itemBuilder: (context, index) {
                Contact contact = this.controller.contacts[index];

                return ListTile(
                  key: Key((contact.id ?? index).toString()),
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
            height: 56.0,
            child: RaisedButton(
              child: AutoSizeText(
                'Add button'.toUpperCase(),
                minFontSize: 16.0,
              ),
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
