import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import "package:http/http.dart" as http;

class WeatherService {
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String sehirAdi) async {
    final response = await http
        .get(Uri.parse("$BASE_URL?q=$sehirAdi&appid=$apiKey&units=metric"));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Hava Durumu Verileri Yüklenemedi");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // Get Permission from User
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Fetch the Current Location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // Convert the Location Into a List of Placemark Objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // Extract the City Name from
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
