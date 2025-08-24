import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_project/Objects/Weatherobject.dart';

class MapProvider extends ChangeNotifier {
  double lat = 0;
  double long = 0;
  WeatherInfo? currentWeather;
  String? city;
  String? state;
  void newlocation(double latitude, double longitude) {
    lat = latitude;
    long = longitude;
    loadWeather();
    notifyListeners();
  }

  Future<void> loadWeather() async {
    final apiKey = "caa96bfe24e2b14aceae9a8bb259e861";

    final geoUrl = Uri.parse(
        "http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$long&limit=1&appid=$apiKey");

    final geoResponse = await http.get(geoUrl);
    if (geoResponse.statusCode != 200) return;

    final geoData = jsonDecode(geoResponse.body);
    if (geoData.isEmpty) return;

    city = geoData[0]['name'] ?? "Unknown";
    state = geoData[0]['state'] ?? geoData[0]['country'] ?? "Unknown";

    // Step 2: Get weather forecast from Open-Meteo
    final weatherUrl = 
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&daily=temperature_2m_max,temperature_2m_min,weather_code,uv_index_max&hourly=temperature_2m&current=temperature_2m,wind_speed_10m,is_day,apparent_temperature,rain,relative_humidity_2m,showers,precipitation&timezone=auto";

    final response2 = await http.get(Uri.parse(weatherUrl));
    if (response2.statusCode == 200) {
      final data = jsonDecode(response2.body);
      currentWeather = WeatherInfo.fromJson(data, state ?? "Unknown");
      notifyListeners();
    }
  }


  void savecity(){
    final box = Hive.box('user');
    List<String> citylist = box.containsKey('cities') ?  box.get('cities') : [];
    if(citylist.contains(city) || city == null){return;}
    citylist.add(city!);
    box.put('cities', citylist);
  }
}
