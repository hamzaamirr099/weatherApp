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

/*
"day": {
        "maxtemp_c": 24.0,
        "mintemp_c": 17.4,
        "daily_will_it_rain": 0,
        "daily_chance_of_rain": 0,
        "condition": {
            "text": "Partly cloudy",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
            "code": 1003
        },
        "uv": 6.0
    },
 */