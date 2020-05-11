import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/Weather.dart';
import 'package:http/http.dart' as http;


class SearchResult  extends StatefulWidget {
    final Weather weatherInfo;
  // receive data from the FirstScreen as a parameter
  SearchResult({Key key, @required this.weatherInfo}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState(weatherInfo);
}

class _SearchResultState extends State<SearchResult> {
  Weather weatherInfo;

  _SearchResultState(this.weatherInfo);

  var _forecast;

  @override
  void initState() {
    super.initState();
    _loadForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App", style: TextStyle(color: Colors.indigo),),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(weatherInfo.place,
                      style: TextStyle(color: Colors.black, fontSize: 24.0)),
                  Image.network('https://openweathermap.org/img/wn/${weatherInfo
                      .icon}@2x.png'),
                  Text(weatherInfo.weather,
                      style: TextStyle(color: Colors.black, fontSize: 30.0)),
                  Text("${weatherInfo.temp}°C",
                      style: TextStyle(color: Colors.black, fontSize: 30.0)),
                  Text(weatherInfo.date, style: TextStyle(
                      color: Colors.black, fontSize: 20.0)),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 200.0,
                        child: _forecast != null ? ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) =>
                                _loadWidget(index, _forecast)
                          //ForecastItem(forecastInfo: _forecast)
                        ) :
                        Container(),
                      ),
                    ),
                  )
                ]
            )
        ),
      ),
      backgroundColor: Colors.grey,
    );
    //http://api.openweathermap.org/data/2.5/forecast/daily?q=Bangalore&APPID=279b4be6d54c8bf6ea9b12275a567156&cnt=5
  }


  _loadForecast() async {
    var queryParameters = {
      'q': weatherInfo.place,
      'cnt': '5',
      'units': 'metric',
      'APPID': 'b4cf8e66f1ea7baa54beef27344a5109',
//      279b4be6d54c8bf6ea9b12275a567156
    };
    var uri = Uri.http('api.openweathermap.org','/data/2.5/forecast', queryParameters);
    final forecastResponse = await http.get(uri);
    var response = jsonDecode(forecastResponse.body);
    debugPrint(forecastResponse.body);
    setState(() {
      _forecast = response;
    });
  }

  _loadWidget(int index,Map<String,dynamic> data) {
    var formatter = new DateFormat('yyyy-MM-dd');
    var rawDate = new DateTime.fromMillisecondsSinceEpoch(data['list'][index]['dt'] * 1000);
    var date=formatter.format(rawDate);
    return Card(
      color: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(date.toString(), style: new TextStyle(color: Colors.black)),
            Text('${data['list'][index]['main']['temp']}°C',  style: new TextStyle(color: Colors.black)),
            Image.network('https://openweathermap.org/img/w/${data['list'][index]['weather'][0]['icon'].toString()}.png'),

          ],
        ),
      ),
    );
  }
}
