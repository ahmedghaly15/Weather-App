import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/weather_model.dart';
import '/providers/weather_provider.dart';
import '/services/weather_service.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    super.key,
  });
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            controller: searchController,
            enableSuggestions: true,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Enter a city name",
              hintStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              suffixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 10,
              ),
            ),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: Colors.black,
            ),
            onSubmitted: (data) async {
              searchController.text = data;
              WeatherService service = WeatherService();
              WeatherModel? weather =
                  await service.getWeather(cityName: searchController.text);
              Provider.of<WeatherProvider>(
                context,
                listen: false,
              ).weatherData = weather;
              if (weather == null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Warning"),
                        content: Text("Invalid City Name"),
                      );
                    });
              } else {
                Navigator.pop(context);
              }
              print(weather);
            },
          ),
        ),
      ),
    );
  }
}
