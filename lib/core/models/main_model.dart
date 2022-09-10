import 'package:weather_app_algoriza/core/models/location_model.dart';
import 'package:weather_app_algoriza/core/models/weather_status.dart';

import 'forecast_day_model.dart';

class MainWeatherModel {
  Location? location;
  WeatherStatus? current;

  List<ForecastDayData> forecastday = [];

  MainWeatherModel.fromJson(Map<String, dynamic> map) {
    location = Location.fromJson(map['location']);
    current = WeatherStatus.fromJson(map['current']);
    // forecast = Forecast.fromJson(map['forecast']);
    for (var element in map['forecast']['forecastday'])
    {
      forecastday.add(ForecastDayData.fromJson(element));
    }

  }
}
