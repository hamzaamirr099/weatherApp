class Location
{
  String? name;
  String? region;
  String? country;
  int? localTimeEpoch;
  String? localTime;

  Location.fromJson(Map<String, dynamic>map)
  {
    name = map['name'];
    region = map['region'];
    country = map['country'];
    localTimeEpoch = map['localtime_epoch'];
    localTime = map['localtime'];
  }
}

/*
"name": "London",
        "region": "City of London, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.11,
        "tz_id": "Europe/London",
        "localtime_epoch": 1662331244,
        "localtime": "2022-09-04 23:40"
 */