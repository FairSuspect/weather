import 'package:flutter/material.dart';
import '../api/api.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final bool byLocation;
  final CurrentWeather? weather;
  CurrentWeatherWidget(
      {Key? key, required this.weather, this.byLocation = true})
      : super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeatherWidget> {
  int celsius(double temp) => ((temp) - 273.15).toInt();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .8,
      // child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.weather?.name ?? "Неизвестно",
                style: theme.textTheme.headline6,
              ),
              Visibility(
                child: Icon(Icons.location_on),
                visible: widget.byLocation,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${celsius((widget.weather?.mainData?.temp ?? 272.15))} °C",
                style: theme.textTheme.headline2,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.network(
                  "https://openweathermap.org/img/wn/${widget.weather?.weather?.icon}@2x.png",
                ),
              ),
              Text(widget.weather?.weather?.description ?? "Нет данных"),
            ],
          ),
          Column(
            children: [
              Text("Ощущается как"),
              Text(
                  "${celsius((widget.weather?.mainData?.feelsLike ?? 272.15))} °C"),
            ],
          )
        ],
      ),
      // ),
    );
  }
}
