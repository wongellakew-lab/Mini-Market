import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mini_market/main.dart';

void main() {
  testWidgets('Mini Market smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify Mini Market title is rendered
    expect(find.text('Mini Market'), findsOneWidget);

    // Verify products are rendered
    expect(find.text('Phone X'), findsOneWidget);
    expect(find.text('Headphones'), findsOneWidget);

    // Tap Phone X to open product details
    await tester.tap(find.text('Phone X'));
    await tester.pumpAndSettle();

    // Verify Product Details page
    expect(find.text('Add to cart'), findsOneWidget);
    expect(find.text('Qty'), findsOneWidget);

    // Add to cart
    await tester.tap(find.text('Add to cart'));
    await tester.pump();

    // Go back to home
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify cart icon exists
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });
}
