import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:weather/cities_screen.dart';
import 'package:weather/services/api.dart';
import 'package:weather/widgets/current_weather_widget.dart';
import 'api/api.dart';
import 'config/env.dart' as envConfig;
import 'services/api.dart' as apiService;
import 'services/dio.dart' as dioService;

void main() async {
  await envConfig.init('.env');
  // _serviceEnabled = await location.serviceEnabled();
  // if (!_serviceEnabled) {
  //   _serviceEnabled = await location.requestService();
  //   if (!_serviceEnabled) {
  //     // return;
  //   }
  // }

  // _permissionGranted = await location.hasPermission();
  // if (_permissionGranted == PermissionStatus.denied) {
  //   _permissionGranted = await location.requestPermission();
  // }
  dioService.init();
  apiService.init();
  var toParse = await rootBundle.loadString('assets/cities.json');
  var _json = json.decode(toParse);
  cities = City.listFromJson(_json);
  runApp(MyApp());
}

List<City> cities = List.empty();
Location location = new Location();

bool _serviceEnabled = false;
PermissionStatus _permissionGranted = PermissionStatus.denied;
LocationData? _locationData =
    LocationData.fromMap({"latitude": 55.73, "longitude": 37.54});

// _locationData = await location.getLocation();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Погода'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  City _city = City();
  void _onCityPressed() async {
    _city = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CitiesScreen())) ??
        _city;

    setState(() {
      print(_city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: _onCityPressed, icon: Icon(Icons.location_city))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onCityPressed,
        child: Icon(Icons.location_city_outlined),
      ),
      body: Center(child: _currentWeatherFuture()
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     FutureBuilder<LocationData?>(
          //       future: location.getLocation(),
          //       builder: (context, snapshot) {
          //         if (_permissionGranted != PermissionStatus.granted)
          //           _noPermission();
          //         if (snapshot.hasData) {
          //           _locationData = snapshot.data;
          //           if (_city.name == '' && _city.country == '') {
          //             _city.lat = _locationData?.latitude;
          //             _city.lon = _locationData?.longitude;
          //           }
          //           return _currentWeatherFuture();
          //         } else if (snapshot.hasError) {
          //           return Text("Location stream error: ${snapshot.error}");
          //         } else
          //           return CircularProgressIndicator();
          //       },
          //     ),
          //   ],
          // ),
          ),
    );
  }

  Widget _currentWeatherFuture() => FutureBuilder<List<CurrentWeather?>?>(
        future: _city.name == '' && _city.country == ''
            ? api.weather.current(_city.lat!, _city.lon!)
            : api.weather.currentByCity(_city.name, _city.country),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CurrentWeatherWidget(
              weather: snapshot.data?.first,
              byLocation: _city.name == '' && _city.country == '',
            );
          } else if (snapshot.hasError)
            return Text(snapshot.error.toString());
          else
            return CircularProgressIndicator();
        },
      );
  Future<Column> _noPermission() async {
    return Column(
      children: [
        Text("Приложению не предоставлен доступ к местоположению устройства"),
        ElevatedButton(
            onPressed: () async {
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }

              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
              }
              setState(() {});
            },
            child: Text("Предоставить"))
      ],
    );
  }
}
