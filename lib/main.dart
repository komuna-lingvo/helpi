import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpi/routes/routes.dart';
import 'package:helpi/translations/translations.dart';
import 'package:helpi/ui/theme/app_colors.dart';
import 'package:helpi/ui/theme/app_theme.dart';
import 'package:helpi/util/licenses.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(licenses);
  runApp(HelpiApp());
}

class HelpiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData defaultTheme = Theme.of(context);
    TextTheme textTheme = AppTheme.textTheme(defaultTheme.textTheme);
    ThemeData theme = AppTheme.defaultTheme.copyWith(
      textTheme: textTheme,
      appBarTheme: AppTheme.appBarTheme.copyWith(
        textTheme: textTheme.apply(
          bodyColor: AppColors.primaryColor,
        ),
      ),
    );

    return GetMaterialApp(
      theme: theme,
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.initial,
      home: AppRoutes.home,
      initialBinding: AppRoutes.initialBindings,
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      translationsKeys: AppTranslations.translationKeys,
    );
  }
}
