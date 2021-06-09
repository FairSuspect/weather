part of '../api.dart';

class WeatherController extends ControllerBase<WeatherController> {
  WeatherController(Dio dio, {String version = "2.5", String key = ""})
      : super(dio, version, key);
  Future<List<CurrentWeather?>?> current(double lat, double long) async {
    try {
      var url = "$v/find?lat=$lat&lon=$long&lang=ru&appid=$key";

      var response = await dio.get(url);
      var currentWeather = CurrentWeather.listFromJson(response.data[r'list']);
      return currentWeather;
    } on DioError catch (e) {
      print(e.error);
      return List.empty();
    }
  }

  Future<List<CurrentWeather?>?> currentByCity(
      String city, String country) async {
    try {
      var url = "$v/find?q=$city,$country&lang=ru&appid=$key";
      var response = await dio.get(url);
      var currentWeather = CurrentWeather.listFromJson(response.data[r'list']);
      return currentWeather;
    } on DioError catch (e) {
      print(e.error);

      return List.empty();
    }
  }
}
