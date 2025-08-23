import 'package:intl/intl.dart';

class HourlyWeather{
  final double temp;
  final String time;
  HourlyWeather({required this.temp,required this.time});
  
}
class DailyWeather{
  final double mintemp;
  final double maxtemp;
  final String date;
  DailyWeather({required this.mintemp,required this.maxtemp,required this.date});
  
}
class WeatherInfo{
  final double temprature;
  final double apptemp;
  final double wind;
  final String time;
  String date;
  final double rainchance;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  String month;
  String day;
  int year;
  String month2;
  String state;
  WeatherInfo({required this.temprature,required this.apptemp,required this.wind,required this.rainchance,required this.state,
  required this.hourly,required this.daily ,required this.time,required this.date,required this.day,required this.month,required this.month2,required this.year
  });
  
 factory WeatherInfo.fromJson(Map<String, dynamic> json,String state) {
    final hourlyJson = json['hourly'];
    final dailyJson = json['daily'];

    List<HourlyWeather> hourlyList = [];
    for (int i = 0; i < hourlyJson['time'].length; i++) {
      hourlyList.add(HourlyWeather(
        time: hourlyJson['time'][i],
        temp: hourlyJson['temperature_2m'][i].toDouble(),
        
      ));
    }

    List<DailyWeather> dailyList = [];
    for (int i = 0; i < dailyJson['time'].length; i++) {
      dailyList.add(DailyWeather(
        date: dailyJson['time'][i],
        mintemp: dailyJson['temperature_2m_max'][i].toDouble(),
        maxtemp: dailyJson['temperature_2m_min'][i].toDouble(),
      ));
    }
    String time = json['current']['time'];
    DateTime date = DateTime.parse(json['current']['time'] ?? "2025-08-07T19:15");
    String month = DateFormat('MMMM yyyy').format(date);
    String  day = DateFormat('EEEE').format(date);
    String  month2 = DateFormat('MMM dd').format(date);
    int  year = date.year;
    return WeatherInfo(
      temprature: json['current']['temperature_2m'].toDouble(),
      apptemp: json['current']['apparent_temperature'].toDouble(),
      wind: json['current']['wind_speed_10m'].toDouble(),
      rainchance: json['current']['rain'].toDouble(),
      time: time.substring(11),
      hourly: hourlyList,
      daily: dailyList,
      date: json['current']['time'],
      day: day,
      year: year,
      month2: month2,
      month: month,
      state: state
    );
  }
}
