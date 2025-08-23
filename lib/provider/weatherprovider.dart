import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_project/Objects/Weatherobject.dart';

class Weatherprovider extends ChangeNotifier{
  WeatherInfo? weatherData;
  String? city;
  String? state;
  String? a;
  String? month;
  String? day;
  int? year;
  String? month2;
  
  Future<void> getweather(String cit) async{
    //print("looking");
    final apiKey = "caa96bfe24e2b14aceae9a8bb259e861";
    final url1 = "http://api.openweathermap.org/geo/1.0/direct?q=$cit&limit=1&appid=$apiKey";
    
    final response1 = await http.get(Uri.parse(url1));
    if(response1.statusCode != 200) return ;
    final decodejson1 = jsonDecode(response1.body);
    city = decodejson1[0]['name'];
    state = state = decodejson1[0]['state'] ?? decodejson1[0]['country'] ?? "Unknown";
    a = decodejson1[0]['name'];
    final lat = decodejson1[0]['lat'];
    final lon = decodejson1[0]['lon'];
    final url2 = "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=temperature_2m_max,temperature_2m_min,weather_code,uv_index_max&hourly=temperature_2m&current=temperature_2m,wind_speed_10m,is_day,apparent_temperature,rain,relative_humidity_2m,showers,precipitation&timezone=auto";
    final response2 = await http.get(Uri.parse(url2));
    if(response2.statusCode == 200){
      final data = jsonDecode(response2.body);
      weatherData = WeatherInfo.fromJson(data,state ?? "Unknown");
      DateTime date = DateTime.parse(weatherData?.date ?? "2025-08-07T19:15");
      month = DateFormat('MMMM yyyy').format(date);
      day = DateFormat('EEEE').format(date);
      month2 = DateFormat('MMM dd').format(date);
      year = date.year;
      print(city);
      notifyListeners();
      
    }
  }

  Future<WeatherInfo?> getcityweather(String cit) async{
    print("looking");
    final apiKey = "caa96bfe24e2b14aceae9a8bb259e861";
    final url1 = "http://api.openweathermap.org/geo/1.0/direct?q=$cit&limit=1&appid=$apiKey";
    
    final response1 = await http.get(Uri.parse(url1));
    if(response1.statusCode != 200) return null;
    final decodejson1 = jsonDecode(response1.body);
    final mycity = decodejson1[0]['name'];
    String mystate  = decodejson1[0]['state'] ?? decodejson1[0]['country'] ?? "Unknown";
    final lat = decodejson1[0]['lat'];
    final lon = decodejson1[0]['lon'];
    final url2 = "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=temperature_2m_max,temperature_2m_min,weather_code,uv_index_max&hourly=temperature_2m&current=temperature_2m,wind_speed_10m,is_day,apparent_temperature,rain,relative_humidity_2m,showers,precipitation&timezone=auto";
    final response2 = await http.get(Uri.parse(url2));
    if(response2.statusCode == 200){
      final data = jsonDecode(response2.body);
      weatherData = WeatherInfo.fromJson(data,mystate ?? "unknown");
      print(city);
      notifyListeners();
      return weatherData ?? null;
      
    }
  }
}