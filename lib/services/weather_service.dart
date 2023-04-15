import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      String baseUrl = 'http://api.weatherapi.com/v1';
      String apiKey = '45408f8097954fac824144551231504';
      Uri url =
          Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');

      http.Response response = await http.get(url);

      Map<String, dynamic> data = jsonDecode(response.body);

      weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
}
