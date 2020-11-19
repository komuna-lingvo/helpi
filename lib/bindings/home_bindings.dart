import 'package:get/get.dart';
import 'package:helpi/controllers/home_controller.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:helpi/data/repository/database.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return HomeController(
        repository: ButtonRepository(database: AppDatabase()),
      );
    });
  }
}
