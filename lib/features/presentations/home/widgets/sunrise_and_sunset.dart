import 'package:flutter/material.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';

import 'container_item.dart';

class SunRiseAndSunset extends StatelessWidget {
  const SunRiseAndSunset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get(context);
    return DefaultContainer(
      widgetItem: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Sunrise",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                Text(
                  "${mainCubit.weatherDataModel!.forecastday[0].astro!.sunRise}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                Image.asset('assets/icons/sunrise1.png', height: 90,),
              ],
            ),
            const SizedBox(
              width: 60,
            ),
            Column(
              children: [
                Text(
                  "Sunset",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                Text(
                  "${mainCubit.weatherDataModel!.forecastday[0].astro!.sunSet}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                Image.asset('assets/icons/sunset1.png', height: 90,),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
