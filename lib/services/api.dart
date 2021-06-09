import 'package:weather/api/api.dart';
import 'dio.dart';

late Api api;

void init() {
  api = Api(dio);
}
