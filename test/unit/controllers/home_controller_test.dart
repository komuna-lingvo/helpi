import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/home_controller.dart';
import 'package:helpi/data/model/button.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:helpi/widgets/helpi_button/controller.dart';
import 'package:mockito/mockito.dart';

class MockButtonRepository extends Mock implements ButtonRepository {}

void main() {
  group('HomeController', () {
    MockButtonRepository repository;

    setUp(() {
      repository = new MockButtonRepository();
    });

    test('should call `getAllButtons` after `build`', () {
      when(repository.getAllButtons()).thenAnswer((_) => Future.value([]));

      HomeController controller = HomeController(repository: repository);

      controller.onReady();

      verify(repository.getAllButtons()).called(1);
    });

    test('should update `isLoading` after results', () async {
      when(repository.getAllButtons()).thenAnswer((_) => Future.value([]));

      HomeController controller = HomeController(repository: repository);

      expect(controller.isLoading.value, equals(true));

      await controller.getAllButtons();

      expect(controller.isLoading.value, equals(false));
    });

    test('should inject `HelpiButtonController` after results', () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      Button button = new Button(id: 1, title: 'button');
      List<Button> buttons = [button];
      when(repository.getAllButtons()).thenAnswer((_) => Future.value(buttons));

      HomeController controller = HomeController(repository: repository);

      await controller.getAllButtons();

      expect(controller.buttons.length, equals(buttons.length));

      HelpiButtonController helpiButtonController = Get.find();

      expect(helpiButtonController, isNot(null));
    });
  });
}
