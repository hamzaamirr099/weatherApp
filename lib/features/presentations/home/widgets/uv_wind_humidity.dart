import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';

import 'container_item.dart';

class UvWindHumidity extends StatelessWidget {
  const UvWindHumidity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get(context);
    return DefaultContainer(
      widgetItem: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [

                  Lottie.asset('assets/animations/sun_animation.json', width: 100, height: 100),

                  Text(
                    "UV index",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                        fontWeight:
                        FontWeight.w500),
                  ),

                  Text(
                    "${mainCubit.weatherDataModel!.current!.uv}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                        color: Colors.grey[200]),
                  ),
                ],
              ),
            ),
            Container(width: 1, height:150, color: Colors.grey[200],),
            Expanded(
              child: Column(

                children: [
                  Lottie.asset('assets/animations/wind_animation.json', width: 100, height: 100),

                  Text(
                    "Wind",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                        fontWeight:
                        FontWeight.w500),
                  ),

                  Text(
                    "${mainCubit.weatherDataModel!.current!.windKph} km/h",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                        color: Colors.grey[200]),
                  ),
                ],
              ),
            ),
            Container(width: 1, height:150, color: Colors.grey[200],),
            Expanded(
              child: Column(
                children: [
                  Lottie.asset('assets/animations/humidity_animation.json', width: 100, height: 100),

                  Text(
                    "Humidity",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${mainCubit.weatherDataModel!.current!.humidity}%",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                        color: Colors.grey[200]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
