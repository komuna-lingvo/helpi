import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:helpi/controllers/home_controller.dart';
import 'package:helpi/data/repository/button_repository.dart';
import 'package:helpi/data/repository/database.dart';
import 'package:helpi/ui/android/home/widget/home.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

class MockHelpiDatabase extends Mock implements AppDatabase {}

class MockButtonRepository extends Mock implements ButtonRepository {}

class MockDatabase extends Mock implements Database {}

void main() {
  group('HomeBody Widget', () {
    HomeController controller;
    ButtonRepository repository;
    MockDatabase db;

    setUpAll(() {
      AppDatabase database = new MockHelpiDatabase();
      repository = new MockButtonRepository();
      db = new MockDatabase();

      when(database.instance).thenAnswer((_) => Future.value(db));

      Get.lazyPut(() => database);
    });

    setUp(() {
      controller = new HomeController(repository: repository);
      Get.lazyPut(() => controller);
    });

    testWidgets('When no results then show SvgPicture',
        (WidgetTester tester) async {
      when(db.query(any))
          .thenAnswer((_) => Future.value(<Map<String, dynamic>>[]));

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Home())));

      final indicator = find.byType(CircularProgressIndicator);
      final image = find.byType(SvgPicture);

      await tester.pump();

      expect(indicator, findsNothing);
      expect(image, findsOneWidget);
    });

    testWidgets('When results then show ListView', (WidgetTester tester) async {
      String title = 'My Button';

      when(db.query(any)).thenAnswer(
        (_) => Future.value(<Map<String, dynamic>>[
          {'id': 1, 'title': title}
        ]),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Home())));

      final indicator = find.byType(CircularProgressIndicator);
      final image = find.byType(SvgPicture);
      final list = find.byType(ListView);

      await tester.pump();

      expect(controller.buttons.length, 1);
      expect(indicator, findsNothing);
      expect(image, findsNothing);
      expect(list, findsOneWidget);
      expect(find.text(title), findsOneWidget);
    });
  });
}
