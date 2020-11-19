import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/ui/android/add_button/add_button.dart';
import 'package:helpi/ui/android/home/widget/home.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE = 'home';

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen...');
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add a button'),
        icon: Icon(Icons.add_circle),
        tooltip: 'Add a button',
        onPressed: () => Get.toNamed(AddButtonScreen.ROUTE),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 64.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(child: Center(child: Home())),
        ),
      ),
    );
  }
}
