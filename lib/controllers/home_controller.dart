import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:helpi/widgets/helpi_button/controller.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var _logger = Logger();

  final ButtonRepository repository;

  HomeController({@required this.repository});

  RxList<Button> buttons = RxList<Button>();
  RxBool isLoading = true.obs;
  RxBool isAvailable = false.obs;

  @override
  void onReady() async {
    this._onWidgetBuild();
    super.onReady();
  }

  Future<void> getAllButtons() async {
    List<Button> buttons = await this.repository.getAllButtons();

    this.isLoading.value = false;

    if (buttons.isEmpty) {
      this._logger.d('no buttons found');
      return false;
    }

    Get.put(HelpiButtonController(repository: this.repository));

    this.buttons.addAll(buttons);
  }

  void _onWidgetBuild() async {
    await this.getAllButtons();

    if (this.buttons.isEmpty) {
      return;
    }

    this._requestSMSPermission();
  }

  void _requestSMSPermission() async {
    if (kDebugMode) {
      this.isAvailable.value = true;
      return;
    }

    try {
      PermissionStatus permissionStatus = await Permission.sms.request();
      this.isAvailable.value = permissionStatus.isGranted;
    } on Exception {
      StackTrace.current;
    }
  }
}
