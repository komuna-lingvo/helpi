import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helpi/core/constants.dart';
import 'package:helpi/core/themes.dart';
import 'package:helpi/main_bindings.dart';
// import 'package:helpi/screen/add_button/add_button.dart';
// import 'package:helpi/screen/add_button/add_button_bindings.dart';
import 'package:helpi/screen/home/binding/home_bindings.dart';
import 'package:helpi/screen/home/home.dart';

Stream<LicenseEntry> addLicenses() async* {
  final license = await rootBundle.loadString('google_fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['google_fonts'], license);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(addLicenses);
  await GetStorage.init();
  runApp(HelpiApp());
}

class HelpiApp extends StatelessWidget {
  final _routes = <GetPage>[
    GetPage(
      name: HomeScreen.ROUTE,
      page: () => HomeScreen(),
      binding: HomeContentBindings(),
    ),
    // GetPage(
    //   name: AddButtonScreen.ROUTE,
    //   page: () => AddButtonScreen(),
    //   binding: AddButtonBindings(),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HelpiAppBindings(),
      title: Constants.APP_NAME,
      initialRoute: HomeScreen.ROUTE,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 300),
      theme: Themes.of(context),
      getPages: this._routes,
    );
  }
}
