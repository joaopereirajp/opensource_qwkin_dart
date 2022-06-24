import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'stateful_view.dart';
import 'view.dart';
import 'view_model.dart';

void main() {
  Widget widget = MultiProvider(
      providers: [ChangeNotifierProvider.value(value: CounterViewModel())],
      child: const MaterialApp(
        home: CounterView(),
      ));

  Widget statefulWidget = MultiProvider(
      providers: [ChangeNotifierProvider.value(value: CounterViewModel())],
      child: const MaterialApp(
        home: StatefulCounterView(),
      ));

  testWidgets('Should render CounterView', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    expect(find.byType(CounterView), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Increase'), findsOneWidget);
    expect(find.text('Decrease'), findsOneWidget);
  });

  testWidgets('Should execute changes on view', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    final increaseButton = find.text('Increase');
    final decreaseButton = find.text('Decrease');

    expect(increaseButton, findsOneWidget);
    expect(decreaseButton, findsOneWidget);

    await tester.tap(increaseButton);
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(decreaseButton);
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Should execute same changes on stateful view',
      (WidgetTester tester) async {
    await tester.pumpWidget(statefulWidget);

    final increaseButton = find.text('Increase');
    final decreaseButton = find.text('Decrease');

    expect(increaseButton, findsOneWidget);
    expect(decreaseButton, findsOneWidget);

    await tester.tap(increaseButton);
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(decreaseButton);
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });
}