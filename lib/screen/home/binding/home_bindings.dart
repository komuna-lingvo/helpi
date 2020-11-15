import 'package:get/get.dart';
import 'package:helpi/screen/home/controller/button_grid_controller.dart';

class HomeContentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ButtonGridController());
  }
}
