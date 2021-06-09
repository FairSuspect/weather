library api;

// DEPENDENCIES
import 'package:dio/dio.dart';
import '../config/env.dart';
// import 'package:flutter/foundation.dart';

// Helpers
part 'helpers/controller_base.dart';
// Controllers
part 'controllers/weather_controller.dart';

// Models
part 'models/main_data.dart';
part 'models/current_weather.dart';
part 'models/weather.dart';
part 'models/city.dart';

class Api {
  final WeatherController weather;
  Api(Dio dio) : weather = WeatherController(dio, key: env.DEFAULT_KEY);
}
