import 'dart:convert';

import 'package:flutter/material.dart';
import 'api/api.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'main.dart';

class CitiesScreen extends StatefulWidget {
  final List? cities;
  CitiesScreen({Key? key, this.cities}) : super(key: key);

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  List<City> _cities = List.empty();

  // Future parseJsonFromAssets(String assetsPath) async {
  //   print('--- Parse json from: $assetsPath');
  //   String jsonVal = await rootBundle.loadString(assetsPath);
  //   return json.decode(jsonVal);
  // }

  @override
  void initState() {
    super.initState();
    _cities =
        widget.cities != null ? City.listFromJson(widget.cities!) : cities;
    // _cities = City.listFromJson(widget.cities ?? []) ?? cities;
    // DefaultAssetBundle.of(context).

    // DefaultAssetBundle.of(context)
    //     .load("assets/data.json")
    //     .then((value) => cities = City.listFromJson(value));
    // final jsonResult = json.decode(data);
  }

  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Выбрать город"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Semantics(
              enabled: true,
              label: "Search",
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Moscow",
                    labelText: "Город"),
              ),
            ),
            Expanded(
                child: _list(_cities
                    .where((city) =>
                        city.name.toLowerCase().contains(query.toLowerCase()))
                    .toList()))
          ],
        ),
      ),
    );
  }

  Widget _list(List<City> cities) => ListView.builder(
        itemCount: cities.length + 1,
        itemBuilder: (context, index) {
          if (index == 0)
            return Semantics(
              enabled: true,
              label: "Tile with current location",
              child: ListTile(
                title: Text("Текущее местоположение"),
                trailing: Icon(Icons.location_searching),
                onTap: () async {
                  var _locationData = await location.getLocation();
                  Navigator.pop(
                      context,
                      City(
                          lat: _locationData.latitude,
                          lon: _locationData.longitude));
                },
              ),
            );
          return Semantics(
            enabled: true,
            label:
                "Tile with city: ${cities[index - 1].name}, ${cities[index - 1].country}",
            child: ListTile(
              title: Text(
                  "${cities[index - 1].name}, ${cities[index - 1].country}"),
              onTap: () {
                Navigator.pop(context, cities[index - 1]);
              },
            ),
          );
        },
      );
}
