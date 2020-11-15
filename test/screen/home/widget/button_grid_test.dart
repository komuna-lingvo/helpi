import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:helpi/core/service/helpi_database.dart';
import 'package:helpi/screen/home/controller/button_grid_controller.dart';
import 'package:helpi/screen/home/widget/button_grid.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

class MockHelpiDatabase extends Mock implements HelpiDatabase {}

class MockDatabase extends Mock implements Database {}

void main() {
  group('ButtonGrid Widget', () {
    ButtonGridController controller;
    MockDatabase db;

    setUpAll(() {
      HelpiDatabase helpi = new MockHelpiDatabase();
      db = new MockDatabase();

      when(helpi.database).thenAnswer((_) => Future.value(db));

      Get.lazyPut(() => helpi);
    });

    setUp(() {
      controller = new ButtonGridController();
      Get.lazyPut(() => controller);
    });

    testWidgets('When no results then show SvgPicture',
        (WidgetTester tester) async {
      when(db.query(any))
          .thenAnswer((_) => Future.value(<Map<String, dynamic>>[]));

      await tester.pumpWidget(ButtonGrid());

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

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: ButtonGrid())));

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
