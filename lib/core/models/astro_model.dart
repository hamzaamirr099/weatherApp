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
