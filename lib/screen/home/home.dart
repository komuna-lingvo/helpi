import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/screen/add_button/add_button.dart';
import 'package:helpi/screen/home/widget/button_grid.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE = 'home';

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen...');
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add button'),
        icon: Icon(Icons.add_circle),
        tooltip: 'Add button',
        onPressed: () => Get.toNamed(AddButtonScreen.ROUTE),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SafeArea(
        child: Container(child: Center(child: ButtonGrid())),
      ),
    );
  }
}
