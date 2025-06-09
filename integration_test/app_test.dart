import 'package:clothly/components/shoping_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:clothly/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Test Full App - ", () {
    testWidgets("all aplication function", (tester) async {
      app.main();

      // HomePage: Tap Hoodie Chip and scroll
      await tester.pumpAndSettle(const Duration(seconds: 10));
      await tester.tap(find.byType(Chip).at(1));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.drag(find.byType(ListView).last, Offset(0, -400));
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // ShopingItem Page
      await tester.tap(find.byType(ShopingItem).at(1));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.drag(find.byType(SingleChildScrollView), Offset(0, -400));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.tap(find.byType(Chip).at(2));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byTooltip(
          'Back')); //The default Flutter AppBar back button uses a tooltip of 'Back'.

      // Search
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.enterText(find.byType(TextField), "Bohemian Maxi Frock");
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.testTextInput
          .receiveAction(TextInputAction.done); // Close keyboard
      await tester.pumpAndSettle();

      // Tap first result after search
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.tap(find.byType(ShopingItem).at(0));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.drag(find.byType(SingleChildScrollView), Offset(0, -400));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.tap(find.byType(Chip).at(0));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byTooltip('Back'));

      // BottomNavigationBar - Cart
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.tap(find.byIcon(Icons.shopping_cart));

      // Cart page: delete item
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await tester.tap(find.byIcon(Icons.delete).last);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.text("Yes"));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // // BottomNavigationBar - Cart
      // await tester.pumpAndSettle(const Duration(seconds: 4));
      // await tester.tap(find.byIcon(Icons.home));

      // //Drawer : logout
      // await tester.pumpAndSettle(const Duration(seconds: 2));
      // await tester.tap(find.byTooltip('Open navigation menu'));
      // await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
