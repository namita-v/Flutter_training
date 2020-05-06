import 'package:flutter/material.dart';
import 'package:weatherapp/models/Weather.dart';


class SearchResult extends StatelessWidget {

 final Weather weatherInfo;
  // receive data from the FirstScreen as a parameter
  SearchResult({Key key, @required this.weatherInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App",style: TextStyle(color: Colors.indigo),),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(weatherInfo.place,style: TextStyle(color: Colors.black, fontSize: 24.0)),
              Image.network('https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png'),
              Text(weatherInfo.weather,style: TextStyle(color: Colors.black, fontSize: 30.0)),
              Text("${weatherInfo.temp}°C",style: TextStyle(color: Colors.black, fontSize: 30.0)),
              Text(weatherInfo.date, style: TextStyle(
                  color: Colors.black, fontSize: 20.0))
            ])
            ),
      backgroundColor: Colors.grey,
      );
    //http://api.openweathermap.org/data/2.5/forecast/daily?q=Bangalore&APPID=279b4be6d54c8bf6ea9b12275a567156&cnt=5
  }
}