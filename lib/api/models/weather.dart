part of '../api.dart';

class Weather {
  String? main;
  String? description;
  String? icon;

  Weather({this.main, this.icon, this.description});

  static Weather? fromJson(Map<String, dynamic>? json) => json == null
      ? null
      : Weather(
          main: json[r'main'],
          icon: json[r'icon'],
          description: json[r'description'],
        );

  static List<Weather?>? listFromJson(
    List<dynamic>? json, {
    bool? emptyIsNull,
    bool? growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <Weather>[]
          : json
              .map((v) => Weather.fromJson(v))
              .toList(growable: true == growable);
}
