import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/add_button_controller.dart';
import 'package:helpi/ui/android/add_button/widget/add_button.dart';

class AddButtonScreen extends GetView<AddButtonController> {
  static const String ROUTE = 'add';

  @override
  Widget build(BuildContext context) {
    print('Building AddButtonScreen...');
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        title: Text('Add a Button'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            tooltip: 'Add Contact',
            onPressed: this.controller.onAddContactPressed,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddButton(),
        ),
      ),
    );
  }
}
