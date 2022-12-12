import 'package:goosit/components/form-fields/email_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GlobalKey<FormState> formKey;
  late TestHelper testHelper;
  setUp(() {
    testHelper = TestHelper();
    formKey = GlobalKey<FormState>();
  });
  testWidgets('given email is empty, then show required error message',
      (WidgetTester tester) async {
    await testHelper.createPage(tester, formKey, null);

    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text("Email é obrigatório"), findsOneWidget);
  });
  testWidgets('given email is invalid, then show invalid error message',
      (WidgetTester tester) async {
    await testHelper.createPage(tester, formKey, null);

    await tester.enterText(find.byKey(const Key("email")), "invalidEmail");
    await tester.pumpAndSettle();

    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text("Email é inválido"), findsOneWidget);
  });
  testWidgets('given email is valid, then do not show error message',
      (WidgetTester tester) async {
    await testHelper.createPage(tester, formKey, null);

    await tester.enterText(find.byKey(const Key("email")), "valid@email.com");
    await tester.pumpAndSettle();

    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text("Email é obrigatório"), findsNothing);
    expect(find.text("Email é inválido"), findsNothing);
  });
  testWidgets('given user changes the email, then reflect email changes',
      (WidgetTester tester) async {
    bool hasExecutedOnChangeFunction = false;
    await testHelper.createPage(tester, formKey, (email) {
      hasExecutedOnChangeFunction = true;
    });

    await tester.enterText(find.byKey(const Key("email")), "anyEmail");
    await tester.pumpAndSettle();

    expect(hasExecutedOnChangeFunction, true);
  });
}

class TestHelper {
  createPage(
    WidgetTester tester,
    GlobalKey<FormState> formKey,
    Function(String)? onChanged,
  ) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: Form(
        key: formKey,
        child: EmailFormField(
          key: const Key("email"),
          onChanged: onChanged,
        ),
      ),
    )));
  }
}
