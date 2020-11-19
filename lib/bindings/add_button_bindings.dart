import 'package:get/get.dart';
import 'package:helpi/controllers/add_button_controller.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:helpi/data/repository/database.dart';
import 'package:helpi/data/service/contacts_service.dart';
import 'package:helpi/data/service/notifications_service.dart';

class AddButtonBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      NotificationsService notificationsService = NotificationsService();

      return AddButtonController(
        repository: ButtonRepository(database: AppDatabase()),
        contactsService:
            AppContactsService(notificationsService: notificationsService),
        notificationsService: notificationsService,
      );
    });
  }
}
