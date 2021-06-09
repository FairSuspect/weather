part of '../api.dart';

class MainData {
  double? temp;
  double? feelsLike;
  double? tempMin;
  int? pressure;
  int? humidity;

  MainData({
    this.temp,
    this.feelsLike,
    this.humidity,
    this.pressure,
    this.tempMin,
  });

  /// Returns a new [MainData] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static MainData? fromJson(Map<String, dynamic>? json) => json == null
      ? null
      : MainData(
          temp: json[r'temp'],
          feelsLike: json[r'feels_like'],
          tempMin: json[r'temp_min'],
          pressure: json[r'pressure'],
          humidity: json[r'humidity'],
        );
}
