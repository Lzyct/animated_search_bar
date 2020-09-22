import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MaterialApp app = MaterialApp(
    home: Scaffold(body: const AnimatedSearchBar()),
  );

  testWidgets('app should work', (tester) async {
    await tester.pumpWidget(app);
    expect(find.byType(AnimatedSearchBar), findsOneWidget);
  });
}
