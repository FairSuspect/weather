part of '../api.dart';

class City {
  String country;
  String name;
  double? lat;
  double? lon;

  City({this.country = '', this.name = '', this.lat = 55.7, this.lon = 37.54});
  static City fromJson(Map<String, dynamic> json) => City(
      country: json[r'country'],
      name: json[r'name'],
      lat: double.tryParse(json[r'lat']),
      lon: double.tryParse(json[r'lng']));

  static List<City> listFromJson(
    List<dynamic> json, {
    bool? growable,
  }) =>
      json.map((v) => City.fromJson(v)).toList(growable: true == growable);
  @override
  String toString() {
    return "Instanse of City: $name, $country, $lat, $lon";
  }
}
