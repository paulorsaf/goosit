import 'package:goosit/components/form-fields/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GlobalKey<FormState> formKey;
  late TestHelper testHelper;
  setUp(() {
    testHelper = TestHelper();
    formKey = GlobalKey<FormState>();
  });
  testWidgets('given password is empty, then show required error message',
      (WidgetTester tester) async {
    await testHelper.createPage(tester: tester, formKey: formKey);

    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text("Senha é obrigatória"), findsOneWidget);
  });
  testWidgets('given email is not empty, then do not show error message',
      (WidgetTester tester) async {
    await testHelper.createPage(tester: tester, formKey: formKey);

    await tester.enterText(find.byKey(const Key("password")), "anyPassword");
    await tester.pumpAndSettle();

    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text("Senha é obrigatória"), findsNothing);
  });
  group('given not revealing password', () {
    testWidgets('then show reveal password button',
        (WidgetTester tester) async {
      await testHelper.createPage(tester: tester, initialVisibility: false);

      expect(find.byKey(const Key("visibility-on")), findsOneWidget);
    });
    testWidgets('when user presses reveal password, then reveal password',
        (WidgetTester tester) async {
      await testHelper.createPage(tester: tester, initialVisibility: false);

      await tester.press(find.byKey(const Key("reveal-password-button")));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("visibility-off")), findsNothing);
    });
  });
  group('given revealing password', () {
    testWidgets('then show hide password button', (WidgetTester tester) async {
      await testHelper.createPage(tester: tester, initialVisibility: true);

      expect(find.byKey(const Key("visibility-off")), findsOneWidget);
    });
    testWidgets('when user presses hide password button, then hide password',
        (WidgetTester tester) async {
      await testHelper.createPage(tester: tester, initialVisibility: true);

      await tester.press(find.byKey(const Key("reveal-password-button")));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("visibility-on")), findsNothing);
    });
  });
}

class TestHelper {
  createPage(
      {required WidgetTester tester,
      GlobalKey<FormState>? formKey,
      Function(String)? onChanged,
      bool? initialVisibility}) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: Form(
        key: formKey,
        child: PasswordFormField(
            key: const Key("password"),
            onChanged: onChanged,
            initialVisibility: initialVisibility),
      ),
    )));
  }
}
