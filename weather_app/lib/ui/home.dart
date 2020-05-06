import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/Weather.dart';
import 'package:weatherapp/ui/SearchResult.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Position _currentPosition;
  Weather _weather;
  Weather _cityWeather;
  TextEditingController searchController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App", style: TextStyle(color: Colors.indigo),),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _weather != null ? <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {

                },
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      tooltip: 'Search',
                      onPressed: () {
                        _searchCity(searchController.text);
                      },
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(_weather.place, style: TextStyle(
                          color: Colors.black, fontSize: 24.0)),
                      Image.network(
                          'https://openweathermap.org/img/wn/${_weather
                              .icon}@2x.png'),
                      Text(_weather.weather, style: TextStyle(
                          color: Colors.black, fontSize: 30.0)),
                      Text("${_weather.temp.toString()}°C", style: TextStyle(
                          color: Colors.black, fontSize: 30.0)),
                      Text(_weather.date, style: TextStyle(
                          color: Colors.black, fontSize: 20.0)),
                    ])
            )

          ] : <Widget>[
            Text("Loading",
                style: TextStyle(color: Colors.black, fontSize: 15.0)),
            new CircularProgressIndicator(backgroundColor: Colors.teal)],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      debugPrint("$_currentPosition");
      _loadWeather(_currentPosition.longitude, _currentPosition.latitude);
    }).catchError((e) {
      print(e);
    });
  }

  _loadWeather(double lon, double lat) async {
    var queryParameters = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'units': 'metric',
      'appid': 'b4cf8e66f1ea7baa54beef27344a5109',
    };
    var uri = Uri.http(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final weatherResponse = await http.get(uri);
    var response = jsonDecode(weatherResponse.body);
    debugPrint(response['weather'][0]['main']);
    _weather = Weather(response);
  }

  _searchCity(String city) async {
    debugPrint(city);
    var queryParameters = {
      'q': city,
      'units': 'metric',
      'appid': 'b4cf8e66f1ea7baa54beef27344a5109',
    };

    var uri = Uri.http(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final cityWeatherResponse = await http.get(uri);
    var response = jsonDecode(cityWeatherResponse.body);

    if (cityWeatherResponse.statusCode == 200) {
      _cityWeather = Weather(response);
      debugPrint(cityWeatherResponse.body);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResult(weatherInfo: _cityWeather),
          ));
    }
    else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(title: Text("404"),
                content: Text("City not found"),
                actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                child: new Text("Close"),
            onPressed: () {
            Navigator.of(context).pop();
            },
            ),
            ],
            );
          }
      );
    }
  }

}