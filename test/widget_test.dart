import 'package:flutter_test/flutter_test.dart';

import 'package:cosutudy/main.dart';

void main() {
  testWidgets('App starts on the Log In screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CoSUtudyApp());
    expect(find.text('Log In'), findsWidgets);
  });
}
