part of '../api.dart';

class CurrentWeather {
  MainData? mainData;
  String? name;
  Weather? weather;

  CurrentWeather({this.mainData, this.name, this.weather});

  static CurrentWeather? fromJson(Map<String, dynamic>? json) => json == null
      ? null
      : CurrentWeather(
          mainData: MainData.fromJson(json[r'main']),
          name: json[r'name'],
          weather: Weather.listFromJson(json[r'weather'])?.first,
        );

  static List<CurrentWeather?>? listFromJson(
    List<dynamic>? json, {
    bool? emptyIsNull,
    bool? growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <CurrentWeather>[]
          : json
              .map((v) => CurrentWeather.fromJson(v))
              .toList(growable: true == growable);
}
