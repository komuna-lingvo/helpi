import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/add_button_controller.dart';
import 'package:helpi/data/model/contact.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:helpi/data/service/contacts_service.dart';
import 'package:helpi/data/service/notifications_service.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common/src/exception.dart';

class MockButtonRepository extends Mock implements ButtonRepository {}

class MockAppContactsService extends Mock implements AppContactsService {}

class MockNotificationsService extends Mock implements NotificationsService {}

void main() {
  group('AddButtonController', () {
    MockButtonRepository repository;
    MockAppContactsService contacts;
    MockNotificationsService notifications;

    Contact mock = new Contact(
      id: 1,
      name: 'Jhon Doe',
      phoneNumber: '999 999 999',
      buttonId: 1,
    );

    setUpAll(() {
      notifications = new MockNotificationsService();

      when(notifications.showSnackbar(any, any)).thenReturn(() {});
    });

    setUp(() {
      repository = new MockButtonRepository();

      when(repository.saveHelpiButton(any, any))
          .thenAnswer((_) => Future.value({}));

      contacts = new MockAppContactsService();

      when(contacts.addContactToDevice()).thenAnswer((_) => Future.value(mock));
      when(contacts.getContactFromDevice())
          .thenAnswer((_) => Future.value(mock));
    });

    test('should add contact to list', () async {
      AddButtonController controller;

      controller = new AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      expect(controller.contacts.length, equals(0));

      await controller.onAddContactPressed();

      expect(controller.contacts.length, equals(1));

      controller = new AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      expect(controller.contacts.length, equals(0));

      await controller.onAddContactsPressed();

      expect(controller.contacts.length, equals(1));
    });

    test('should add unique phone numbers', () async {
      AddButtonController controller;

      controller = new AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      await controller.onAddContactPressed();
      await controller.onAddContactPressed();
      await controller.onAddContactPressed();

      expect(controller.contacts.length, equals(1));
    });

    test('should add no more than max contacts', () async {
      Contact contact1 =
          new Contact(name: 'Tester 1', phoneNumber: '888 888 888');
      Contact contact2 =
          new Contact(name: 'Tester 2', phoneNumber: '777 777 777');
      Contact contact3 =
          new Contact(name: 'Tester 3', phoneNumber: '666 666 666');
      Contact contact4 =
          new Contact(name: 'Tester 4', phoneNumber: '555 555 555');
      Contact contact5 =
          new Contact(name: 'Tester 5', phoneNumber: '444 444 444');

      AddButtonController controller;

      controller = new AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      await controller.onAddContactPressed();

      when(contacts.addContactToDevice())
          .thenAnswer((_) => Future.value(contact1));
      await controller.onAddContactPressed();

      when(contacts.addContactToDevice())
          .thenAnswer((_) => Future.value(contact2));
      await controller.onAddContactPressed();

      when(contacts.addContactToDevice())
          .thenAnswer((_) => Future.value(contact3));
      await controller.onAddContactPressed();

      when(contacts.addContactToDevice())
          .thenAnswer((_) => Future.value(contact4));
      await controller.onAddContactPressed();

      when(contacts.addContactToDevice())
          .thenAnswer((_) => Future.value(contact5));
      await controller.onAddContactPressed();

      expect(controller.maxContacts, equals(controller.contacts.length));
      expect(controller.isAddContactDisable.value, equals(true));
    });

    test('should add `Helpi` button to database', () async {
      Get.testMode = true;

      String title = 'Helpi';
      AddButtonController controller;

      controller = new AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      controller.titleTextController.text = title;

      await controller.onAddButtonPressed();

      verify(notifications.showSnackbar(any, any)).called(1);
    }, skip: 'Get.testMode not recognized');

    test('when adding button with same title then should fail', () async {
      when(repository.saveHelpiButton(any, any))
          .thenThrow(new SqfliteDatabaseException('exception', null));

      String title = 'Helpi';
      AddButtonController controller;

      controller = new AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      controller.titleTextController.text = title;

      await controller.onAddButtonPressed();

      verify(notifications.showSnackbar(any, any)).called(1);
    });

    test('when contacts permission denied then should show message', () async {
      when(contacts.addContactToDevice()).thenThrow(new Exception());
      when(contacts.getContactFromDevice()).thenThrow(new Exception());

      AddButtonController controller;
      controller = AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      await controller.onAddContactPressed();

      await controller.onAddContactsPressed();

      verify(notifications.showSnackbar(any, any)).called(2);
    });

    test('when no action from contacts app then should NOT fail', () async {
      when(contacts.addContactToDevice()).thenAnswer((_) => null);
      when(contacts.getContactFromDevice()).thenAnswer((_) => null);

      AddButtonController controller;
      controller = AddButtonController(
        repository: repository,
        contactsService: contacts,
        notificationsService: notifications,
      );

      await controller.onAddContactPressed();

      await controller.onAddContactsPressed();

      verifyNever(notifications.showSnackbar(any, any));
    });
  });
}
