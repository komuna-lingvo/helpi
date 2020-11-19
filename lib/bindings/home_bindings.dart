import 'package:get/get.dart';
import 'package:helpi/screen/home/controller/home_body_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeBodyController());
  }
}
