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
