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
