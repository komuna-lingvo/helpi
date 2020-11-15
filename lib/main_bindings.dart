import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:helpi/core/service/helpi_database.dart';

class HelpiAppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HelpiDatabase());
  }
}
