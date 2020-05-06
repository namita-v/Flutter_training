import 'package:intl/intl.dart';
class Weather {
  String place;
  String weather;
  String temp;
  String icon;
  String date;
  var formatter = new DateFormat('yyyy-MM-dd');
  Weather(Map<String, dynamic> data) {
    place = data['name'];
    weather = data['weather'][0]["main"];
    temp =  data['main']['temp'].toString();
    icon = data['weather'][0]["icon"];
    var rawDate = new DateTime.fromMillisecondsSinceEpoch(data['dt']*1000);
    date = formatter.format(rawDate);

  }
}