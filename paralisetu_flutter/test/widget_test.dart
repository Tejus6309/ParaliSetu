import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralisetu_flutter/app/app.dart';

void main() {
  testWidgets('ParaliSetuApp smoke test renders root app tree', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: ParaliSetuApp(),
      ),
    );

    // Initial render should show Splash or Auth screen
    expect(find.byType(ParaliSetuApp), findsOneWidget);
  });
}
