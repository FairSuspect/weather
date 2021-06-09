import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Запуск приложения", () {
    testWidgets("Прогрузка", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      expect(
          find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == "Ощущается как"),
          findsOneWidget);
    });
    testWidgets("Выбор города", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));
      final feelsLike = find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == "Ощущается как");
      expect(feelsLike, findsOneWidget);
      final locationCityFinder = find.byIcon(Icons.location_city);
      expect(locationCityFinder, findsOneWidget);
      await tester.tap(locationCityFinder);
      await tester.pumpAndSettle();
      expect(feelsLike, findsNothing);
      final input = find.byWidgetPredicate((widget) => widget is TextFormField);
      expect(input, findsOneWidget);
      await tester.enterText(input, "Moscow");
      await tester.pumpAndSettle();
      await tester.tap(find.bySemanticsLabel("Moscow, RU"));
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Text && widget.data!.contains(" °C")),
          findsWidgets);
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == "Moscow"),
          findsOneWidget);

      expect(feelsLike, findsOneWidget);
    });
    testWidgets("Выбор города с помощью FloatingActionButton",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));
      final feelsLike = find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == "Ощущается как");
      expect(feelsLike, findsOneWidget);
      final locationCityFinder =
          find.byWidgetPredicate((widget) => widget is FloatingActionButton);
      expect(locationCityFinder, findsOneWidget);
      await tester.tap(locationCityFinder);
      await tester.pumpAndSettle();
      expect(feelsLike, findsNothing);
      final input = find.byWidgetPredicate((widget) => widget is TextFormField);
      expect(input, findsOneWidget);
      await tester.enterText(input, "Losino-Petrovskiy");
      await tester.pumpAndSettle();
      await tester.tap(find.bySemanticsLabel("Losino-Petrovskiy, RU"));
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Text && widget.data!.contains(" °C")),
          findsWidgets);
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == "Losino-Petrovskiy"),
          findsOneWidget);

      expect(feelsLike, findsOneWidget);
    });
  });
}
