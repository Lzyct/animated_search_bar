import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MaterialApp app = MaterialApp(
    home: Scaffold(body: AnimatedSearchBar()),
  );

  testWidgets('app should work', (tester) async {
    await tester.pumpWidget(app);
    expect(find.byType(AnimatedSearchBar), findsOneWidget);
    expect(find.byKey(const ValueKey('search')), findsOneWidget);
    expect(find.byKey(const ValueKey('close')), findsNothing);

    expect(find.text('Search'), findsNothing);
  });

  testWidgets('after tap search button', (tester) async {
    await tester.pumpWidget(app);
    expect(find.byType(AnimatedSearchBar), findsOneWidget);
    expect(find.byKey(const ValueKey('search')), findsOneWidget);
    expect(find.byKey(const ValueKey('close')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('search')));
    await tester.pump();

    expect(find.byKey(const ValueKey('search')), findsNothing);
    expect(find.byKey(const ValueKey('close')), findsOneWidget);

    expect(find.text('Search'), findsOneWidget);
  });
}
