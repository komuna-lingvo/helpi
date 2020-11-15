import 'package:get/get.dart';
import 'package:helpi/core/model/button.dart';
import 'package:helpi/core/service/helpi_database.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class ButtonGridController extends GetxController {
  var _logger = Logger();

  Database _database;
  bool _hasPermissions = false;

  RxList<Button> buttons = List<Button>.empty(growable: true).obs;
  RxBool isLoading = true.obs;

  @override
  void onReady() async {
    super.onReady();
    await this._initializeServices();
    this.buttons.addAll(await this._getAllButtons());
    this.isLoading.value = false;
    this._hasPermissions = await this._isSMSPermissionGranted();
  }

  Future<void> _initializeServices() async {
    HelpiDatabase helpi = Get.find();
    this._database = await helpi.database;
  }

  Future<List<Button>> _getAllButtons() async {
    List<Button> buttons = <Button>[];

    try {
      final List<Map<String, dynamic>> results =
          await this._database.query(HelpiDatabase.TABLE_BUTTONS);

      _logger.d('results: ${results.length}');

      results.forEach((element) {
        buttons.add(Button.fromJson(element));
      });

      _logger.d('buttons: ${buttons.length}');

      return buttons;
    } on Exception {
      StackTrace.current;
    }

    return buttons;
  }

  Future<bool> _isSMSPermissionGranted() async {
    try {
      PermissionStatus permissionStatus = await Permission.sms.request();
      return permissionStatus.isGranted;
    } on Exception {
      StackTrace.current;
      return false;
    }
  }
}
