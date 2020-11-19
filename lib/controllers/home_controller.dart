import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/data/service/helpi_button_service.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var _logger = Logger();

  final HelpiButtonService service;

  HomeController({@required this.service});

  RxList<Button> buttons = RxList<Button>();
  RxBool isLoading = true.obs;
  RxBool isAvailable = false.obs;

  @override
  void onReady() async {
    super.onReady();
    this.getAllButtons();
  }

  void getAllButtons() async {
    List<Button> buttons = await this.service.getAllButtons();

    this.isLoading.value = false;

    if (buttons.isEmpty) {
      return;
    }

    Get.lazyPut(() => HelpiButtonController());

    this.buttons.addAll(buttons);

    this.isAvailable.value = await this._isSMSPermissionGranted();
  }

  Future<bool> _isSMSPermissionGranted() async {
    try {
      PermissionStatus permissionStatus = await Permission.sms.request();
      _logger.d('has sms permissions?', permissionStatus.isGranted);
      return permissionStatus.isGranted;
    } on Exception {
      StackTrace.current;
      return false;
    }
  }
}
