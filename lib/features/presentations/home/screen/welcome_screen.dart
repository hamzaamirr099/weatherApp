import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_states.dart';

import '../../../../core/shared/functions.dart';
import '../../../../core/widgets/default_text_field.dart';

class WelcomeScreen extends StatelessWidget {

  final MainStates currentState;

  const WelcomeScreen({Key? key, required this.currentState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Weather App",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
              const SizedBox(
                height: 20,
              ),
              DefaultFormField(
                hintText: "Enter a location...",
                controller: mainCubit.countryNameController,
                onFieldSubmitted: (value) {
                  if (value!.isNotEmpty) {
                    mainCubit.getWeatherData(
                        countryName:
                        mainCubit.countryNameController.text);
                  } else {
                    showToastMessage(message: "Enter a location");
                  }
                },
              ),
              // const SizedBox(
              //   height: 10,
              // ),

              if (currentState is LoadingState)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: LinearProgressIndicator(
                    color: Colors.amberAccent,
                  ),
                ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey[200],
                        )),
                    Text(
                      "  Or  ",
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                    ),
                    Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey[200],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ConditionalBuilder(
                  condition: currentState is! LoadingLonAndLatState,
                  builder: (context) =>
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff171717),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            mainCubit.getLonAndLat();
                          },
                          child: Text(
                            "Get current location",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium,
                          ),
                        ),
                      ),
                  fallback: (context) => const Center(child: CircularProgressIndicator(),)
              ),

            ],
          ),
        ),
      ),
    );
  }
}
