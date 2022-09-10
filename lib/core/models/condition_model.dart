class Condition
{
  String? text;
  String? icon;

  Condition.fromJson(Map<String, dynamic>map)
  {
    text = map['text'];
    icon = map['icon'];

  }
}