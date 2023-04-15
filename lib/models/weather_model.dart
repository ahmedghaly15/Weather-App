import 'package:flutter/material.dart';

class WeatherModel {
  String name;
  DateTime date;
  String weatherStateName;
  double temp;
  double maxTemp;
  double minTemp;

  WeatherModel({
    required this.name,
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.weatherStateName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    return WeatherModel(
      name: data['location']['name'],
      date: DateTime.parse(data['location']['localtime']),
      maxTemp: jsonData['maxtemp_c'],
      minTemp: jsonData['mintemp_c'],
      temp: jsonData['avgtemp_c'],
      weatherStateName: jsonData['condition']['text'],
    );
  }

  String getImage() {
    if (weatherStateName == 'Clear' || weatherStateName == 'Light Cloud') {
      return "assets/images/clear.png";
    } else if (weatherStateName == 'Sleet' ||
        weatherStateName == 'Snow' ||
        weatherStateName == 'Hail') {
      return "assets/images/snow.png";
    } else if (weatherStateName == 'Heavy Cloud') {
      return "assets/images/cloudy.png";
    } else if (weatherStateName == 'Light Rain' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers') {
      return "assets/images/rainy.png";
    } else if (weatherStateName == 'Thunderstorm' ||
        weatherStateName == 'Thunder') {
      return "assets/images/thunderstorm.png";
    } else {
      return "assets/images/clear.png";
    }
  }

  MaterialColor getThemeData() {
    if (weatherStateName == 'Clear' || weatherStateName == 'Light Cloud') {
      return Colors.orange;
    } else if (weatherStateName == 'Sleet' ||
        weatherStateName == 'Snow' ||
        weatherStateName == 'Hail') {
      return Colors.blue;
    } else if (weatherStateName == 'Heavy Cloud') {
      return Colors.blueGrey;
    } else if (weatherStateName == 'Light Rain' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Heavy rain' ||
        weatherStateName == 'Showers') {
      return Colors.blue;
    } else if (weatherStateName == 'Thunderstorm' ||
        weatherStateName == 'Thunder') {
      return Colors.grey;
    } else {
      return Colors.orange;
    }
  }
}
