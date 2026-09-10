import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:assignment5/main.dart';

void main() {
  testWidgets(
    'Todo app displays initial tasks',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TodoApp(),
      );

      expect(
        find.text('My Todo List'),
        findsOneWidget,
      );

      expect(
        find.text('Complete Flutter assignment'),
        findsOneWidget,
      );

      expect(
        find.text('Study StatefulWidget'),
        findsOneWidget,
      );

      expect(
        find.text('Practice setState'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'User can add a todo',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TodoApp(),
      );

      await tester.enterText(
        find.byType(TextField),
        'Submit Assignment 5',
      );

      await tester.tap(
        find.byIcon(Icons.add),
      );

      await tester.pump();

      expect(
        find.text('Submit Assignment 5'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'User can mark a todo as complete',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TodoApp(),
      );

      final Finder checkbox =
          find.byType(Checkbox).first;

      await tester.tap(checkbox);
      await tester.pump();

      expect(
        find.text('Completed'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'User can delete a todo',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TodoApp(),
      );

      expect(
        find.text('Complete Flutter assignment'),
        findsOneWidget,
      );

      await tester.tap(
        find.byIcon(Icons.delete_outline).first,
      );

      await tester.pump();

      expect(
        find.text('Complete Flutter assignment'),
        findsNothing,
      );
    },
  );
}