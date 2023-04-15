import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/weather_model.dart';
import '/modules/search_screen.dart';
import '/providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherModel? weatherData = Provider.of<WeatherProvider>(
      context,
      listen: true,
    ).weatherData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: weatherData == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'There is no weather 😔\nstart searching now 🔍',
                    style: TextStyle(
                      fontSize: 30,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    weatherData.getThemeData(),
                    weatherData.getThemeData().withOpacity(0.75),
                    weatherData.getThemeData().withOpacity(0.65),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 3),
                  Text(
                    weatherData.name,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Updated at: ${weatherData.date.hour.toString()}:${weatherData.date.minute.toString()}",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    weatherData.weatherStateName,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(weatherData.getImage()),
                      Text(
                        "${weatherData.temp}",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "max: ${weatherData.maxTemp}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "min: ${weatherData.minTemp}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
    );
  }
}
