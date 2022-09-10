class Astro
{
  String? sunRise;
  String? sunSet;

  Astro.fromJson(Map<String, dynamic>map)
  {
    sunRise = map['sunrise'];
    sunSet = map['sunset'];

  }
}

/*
"astro": {
    "sunrise": "06:17 AM",
    "sunset": "07:41 PM",
    "moonrise": "04:13 PM",
    "moonset": "11:15 PM",
    "moon_phase": "First Quarter",
    "moon_illumination": "57"
},
 */