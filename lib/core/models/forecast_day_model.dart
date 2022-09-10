import 'package:weather_app_algoriza/core/models/hour_model.dart';

import 'astro_model.dart';
import 'day_model.dart';

class ForecastDayData
{
  String? date;
  Day? day;
  Astro? astro;
  List<Hour> hour = [];

  ForecastDayData.fromJson(Map<String, dynamic> map)
  {
    date = map['date'];
    day = Day.fromJson(map['day']);
    astro = Astro.fromJson(map['astro']);
    map['hour'].forEach((element) {
      hour.add(Hour.fromJson(element));
    });

  }
}