import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenAppState createState() => _WeatherScreenAppState();
}

class _WeatherScreenAppState extends State<WeatherApp> {
  String locationName = '';
  String temperature = '';
  String weatherIcon = '';
  String weatherDescription = '';
  String maxTemperature = '';
  String minTemperature = '';
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    weatherData();
  }

  Future<void> weatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=Dhaka,bangladesh&appid=40895a4b1c4e0660c55876c0c40034f1'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final mainData = jsonData['main'];
        final weatherData = jsonData['weather'][0];

        setState(() {
          locationName = jsonData['name'];
          weatherDescription = weatherData['description'];
          weatherIcon = weatherData['icon'];
          temperature = mainData['temp'].toStringAsFixed(1);
          minTemperature = mainData['temp_min'].toStringAsFixed(1);
          maxTemperature = mainData['temp_max'].toStringAsFixed(1);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Weather',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 90, 7, 233),
              Color.fromARGB(255, 150, 97, 240),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isError
                ? const Center(
                    child: Text(
                      'Found an error fetching the weather data',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 130.0),
                      Text(
                        locationName,
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Updated: ${DateFormat.jm().format(DateTime.now())}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Colors.white),
                      ),
                      const SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 130.0,
                            width: 130.0,
                            child: Image.network(
                              getWeatherImageUrl(weatherIcon),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            ' $temperature°C',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Column(
                            children: [
                              Text(
                                'min: $minTemperature°C',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'max: $maxTemperature°C',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        weatherDescription,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  String getWeatherImageUrl(String iconCode) {
    return 'https://openweathermap.org/img/w/$iconCode.png';
  }
}
