import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cosutudy/main.dart';
import 'package:cosutudy/screens/account_widgets.dart';
import 'package:cosutudy/utils/theme_controller.dart';

void main() {
  setUp(() {
    DemoAccount.reset();
    ThemeController.mode.value = ThemeMode.light;
  });

  test('University email, student ID and password validation', () {
    expect(AccountValidation.email(' user@SABANCIUNIV.EDU '), isNull);
    for (final invalid in [
      '',
      'a@gmail.com',
      'a b@sabanciuniv.edu',
      'a@@sabanciuniv.edu',
    ]) {
      expect(AccountValidation.email(invalid), isNotNull);
    }
    expect(AccountValidation.studentId('12345'), isNull);
    expect(AccountValidation.studentId('12a'), isNotNull);
    expect(AccountValidation.password('12345'), isNotNull);
    expect(AccountValidation.password('123456'), isNull);
    expect(AccountValidation.requiredText('  '), isNotNull);
  });

  testWidgets('Login rejects empty form and allows demo navigation', (
    tester,
  ) async {
    await tester.pumpWidget(const CoSUtudyApp());
    await tester.tap(find.widgetWithText(FilledButton, 'Log In'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your Sabancı University email.'), findsOneWidget);
    expect(find.text('Enter your password.'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'student@sabanciuniv.edu',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'demo123');
    await tester.tap(find.byTooltip('Show password'));
    await tester.pump();
    expect(
      tester
          .widget<TextFormField>(find.byType(TextFormField).at(1))
          .controller!
          .text,
      'demo123',
    );
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Log In'));
    await tester.tap(find.widgetWithText(FilledButton, 'Log In'));
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('Sign up, profile, activity navigation and logout', (
    tester,
  ) async {
    await tester.pumpWidget(const CoSUtudyApp());
    await tester.ensureVisible(find.widgetWithText(TextButton, 'Sign Up'));
    await tester.tap(find.widgetWithText(TextButton, 'Sign Up'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Test Student');
    await tester.enterText(fields.at(1), '34567');
    await tester.enterText(fields.at(2), 'test@sabanciuniv.edu');
    await tester.enterText(fields.at(3), 'secret123');
    await tester.enterText(fields.at(4), 'different');
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Sign Up'));
    await tester.tap(find.widgetWithText(FilledButton, 'Sign Up'));
    await tester.pumpAndSettle();
    expect(find.text('Passwords do not match.'), findsOneWidget);
    await tester.enterText(fields.at(4), 'secret123');
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Sign Up'));
    await tester.tap(find.widgetWithText(FilledButton, 'Sign Up'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.person_outline).last);
    await tester.pumpAndSettle();
    expect(find.text('Test Student'), findsNWidgets(2));
    expect(find.text('34567'), findsOneWidget);
    expect(DemoAccount.created, 0);
    await tester.ensureVisible(find.text('Created'));
    await tester.tap(find.text('Created'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      1,
    );
    await tester.tap(find.byIcon(Icons.person_outline).last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Log Out'));
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Log In'), findsOneWidget);
    expect(Navigator.of(tester.element(find.byType(Form))).canPop(), isFalse);
  });

  testWidgets('Narrow dark layout handles signup and back navigation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    ThemeController.mode.value = ThemeMode.dark;
    await tester.pumpWidget(const CoSUtudyApp());
    await tester.ensureVisible(find.widgetWithText(TextButton, 'Sign Up'));
    await tester.tap(find.widgetWithText(TextButton, 'Sign Up'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Log In'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
