import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API Key
  final _weatherService = WeatherService("9a7b3e9b9d44753bb4eaaf71b489e546");

  Weather? _weather;

  // Fetch Weather
  _fetchWeather() async {
    // Get the Current City
    String cityName = await _weatherService.getCurrentCity();
    // Get Weather for City
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // Any Errors
    catch (e) {
      print(e);
    }
  }

  // weather Animations
  String getWeatherAnimation(String? havaDurumu) {
    if (havaDurumu == null) return "assets/sunny.json";

    switch (havaDurumu.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloudy.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rainy.json";
      case "thunderstorm":
        return "assets/snowy.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // Fetch Weather on Startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sehir Adi
            Text(
              _weather?.sehirAdi ?? "Şehir Adı Yükleniyor...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Animation
            Lottie.asset(getWeatherAnimation(_weather?.havaDurumu)),
            // Sicaklik
            Text(
              "${_weather?.sicaklik.round()}°C",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Hava Durumu
            Text(
              _weather?.havaDurumu ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
