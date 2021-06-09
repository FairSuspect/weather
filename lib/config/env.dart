import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore_for_file: non_constant_identifier_names
late Env env;

class Env {
  String DEFAULT_KEY;

  String? API_BASE_URL;
  Env({this.DEFAULT_KEY = "", this.API_BASE_URL});
}

Future<void> init(String path) async {
  String? getKey(String key) => dotenv.env[key] ?? null;

  await dotenv.load(fileName: path);
  env = Env();
  env.DEFAULT_KEY = dotenv.env['DEFAULT_KEY'] ?? "";
  env.API_BASE_URL = dotenv.env['API_BASE_URL'] ?? null;
}
