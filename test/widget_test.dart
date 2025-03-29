import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_sqlite/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MiApp());  // Aquí sí puedes usar 'const'

    // Verifica que el contador comienza en 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Toca el ícono '+' y dispara un frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador ha incrementado.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
