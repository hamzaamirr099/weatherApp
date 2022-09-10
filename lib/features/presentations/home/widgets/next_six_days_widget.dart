import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/forecast_day_model.dart';
import 'container_item.dart';

class NextSixDays extends StatelessWidget {

  final List<ForecastDayData> forecastList;
  const NextSixDays({Key? key, required this.forecastList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      widgetItem: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // forecastPerDay(context),
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => forecastPerDay(context: context, forecastDayData: forecastList[index]),
              itemCount: 7,
            ),
          ],
        ),
      ),
    );
  }
}

Widget forecastPerDay({required BuildContext context, required ForecastDayData forecastDayData}) {

  String day = DateFormat('EEE').format(DateTime.parse(forecastDayData.date as String));

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Text(
          day == DateFormat("EEE").format(DateTime.now()) ? "Today" :day,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Spacer(),
        Icon(
          Icons.water_drop,
          color: Colors.grey[200],
        ),
        Text(
          "${forecastDayData.day!.dailyChanceOfRain}%",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.grey[200]),
        ),
        const SizedBox(width: 25,),
        const Icon(
          Icons.brightness_1,
          color: Colors.yellow,
        ),
        const SizedBox(width: 5,),
        const Icon(
          Icons.dark_mode,
          color: Colors.yellow,
        ),
        const SizedBox(width: 25,),
        Text(
          "${forecastDayData.day!.minTempC!.floor()}\u00B0 / ${forecastDayData.day!.maxTempC!.floor()}\u00B0",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    ),
  );
}
