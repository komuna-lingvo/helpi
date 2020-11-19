import 'package:get/get.dart';
import 'package:helpi/bindings/add_button_bindings.dart';
import 'package:helpi/bindings/home_bindings.dart';
import 'package:helpi/ui/android/add_button/add_button.dart';
import 'package:helpi/ui/android/home/home.dart';

class AppRoutes {
  static final initial = HomeScreen.ROUTE;
  static final home = HomeScreen();
  static final initialBindings = HomeBindings();

  static final routes = <GetPage>[
    GetPage(
      name: HomeScreen.ROUTE,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AddButtonScreen.ROUTE,
      page: () => AddButtonScreen(),
      binding: AddButtonBindings(),
    ),
  ];
}
