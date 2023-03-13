import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project_todo_list_flutter/main.dart';

void main() {
  testWidgets('MyHome widget is rendered', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyHome), findsOneWidget);
  });

  testWidgets('Form validation works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('O campo da tarefa é obrigatório'), findsOneWidget);
  });

  testWidgets('Task is added to the list when add button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextFormField), 'Nova tarefa');
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Nova tarefa'), findsOneWidget);
  });

  testWidgets('Task is removed from the list when delete button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextFormField), 'Tarefa a ser removida');
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Tarefa a ser removida'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.delete).last);
    await tester.pumpAndSettle();
    expect(find.text('Tarefa a ser removida'), findsNothing);
  });
}
