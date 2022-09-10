import 'condition_model.dart';

class WeatherStatus
{
  Condition? condition;
  double? tempC;
  double? windKph;
  double? feelsLikeC;
  double? uv;
  int? humidity;

  WeatherStatus.fromJson(Map<String, dynamic>map)
  {
    condition = Condition.fromJson(map['condition']);
    tempC = map['temp_c'];
    windKph = map['wind_kph'];
    humidity = map['humidity'];
    feelsLikeC = map['feelslike_c'];
    uv = map['uv'];

  }
}
/*
"temp_c": 19.0,
"wind_kph": 15.1,
"humidity": 64,
"feelslike_c": 19.0,
"uv": 1.0,
 */