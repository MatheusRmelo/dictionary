import 'package:dictionary/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dictionary/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('verify login screen with correct email and password',
        (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), 'test@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(1), '123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
