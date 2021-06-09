// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/cities_screen.dart';
import '../lib/api/api.dart' as Api;
import 'package:weather/widgets/current_weather_widget.dart';

//
void main() {
  // testWidgets('Правильное расположение элементов на главном экране',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //   await tester.pump(Duration(seconds: 5));

  //   expect(find.byIcon(Icons.location_city), findsOneWidget);
  //   expect(find.byIcon(Icons.arrow_forward), findsNothing);
  //   // expect(find.text("Ощущается как"), findsOneWidget);
  // });
  // testWidgets("description", callback)
  testWidgets('Отображение списка городов', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final _json = [
      {
        "country": "RU",
        "name": "Losino-Petrovskiy",
        "lat": "55.86959",
        "lng": "38.20065"
      },
      {"country": "RU", "name": "Moscow", "lat": "55.75222", "lng": "37.61556"}
    ];
    final widget = MaterialApp(
      home: CitiesScreen(
        cities: _json,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pump(Duration(seconds: 5));
    expect(find.byWidgetPredicate((widget) => widget is TextFormField),
        findsOneWidget);
    // В списке должна присутствовать карточка для выбора текущего местоположения
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Icon && widget.icon == Icons.location_searching),
        findsOneWidget);

    await tester.enterText(find.byType(TextFormField), "Moscow");
    await tester.pump(Duration(seconds: 5));

    await tester.tap(find.bySemanticsLabel("Moscow, RU"));
  });
  // testWidgets("Отображение виджета погоды", (WidgetTester tester) async {
  //   // CurrentWeather? weather;
  //   final json = [
  //     {
  //       "id": 528454,
  //       "name": "Matveyevskoye",
  //       "coord": {"lat": 55.7069, "lon": 37.4731},
  //       "main": {
  //         "temp": 284.19,
  //         "feels_like": 282.66,
  //         "temp_min": 284.15,
  //         "temp_max": 284.26,
  //         "pressure": 1019,
  //         "humidity": 50
  //       },
  //       "dt": 1622451927,
  //       "wind": {"speed": 4, "deg": 50},
  //       "sys": {"country": "RU"},
  //       "rain": {"1h": 0.21},
  //       "snow": null,
  //       "clouds": {"all": 0},
  //       "weather": [
  //         {
  //           "id": 500,
  //           "main": "Rain",
  //           "description": "небольшой дождь",
  //           "icon": "10d"
  //         }
  //       ]
  //     }
  //   ];
  //   final weather = Api.CurrentWeather.listFromJson(json)?.first;
  //   Api.CurrentWeather? _weather = Api.CurrentWeather(name: "Moscow");
  //   await tester.pumpWidget(MaterialApp(
  //     home: CurrentWeatherWidget(weather: weather),
  //   ));
  // });
}
