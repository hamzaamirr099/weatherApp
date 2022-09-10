class Hour
{
  String? time;
  double? tempC;

  Hour.fromJson(Map<String, dynamic> map)
  {
    time = map['time'];
    tempC = map['temp_c'];


  }
}
