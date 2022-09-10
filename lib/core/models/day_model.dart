import 'package:weather_app_algoriza/core/models/condition_model.dart';

class Day
{
  double? maxTempC;
  double? minTempC;
  Condition? condition;
  double? uv;
  int? dailyChanceOfRain;

  Day.fromJson(Map<String, dynamic>map)
  {
    maxTempC = map['maxtemp_c'];
    minTempC = map['mintemp_c'];
    dailyChanceOfRain = map['daily_chance_of_rain'];
    condition = Condition.fromJson(map['condition']);
    uv = map['uv'];

  }
}
