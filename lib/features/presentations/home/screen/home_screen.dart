import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_algoriza/core/shared/functions.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_states.dart';
import 'package:weather_app_algoriza/core/utils/settings_bloc/settings_cubit.dart';
import 'package:weather_app_algoriza/core/widgets/default_text_field.dart';
import 'package:weather_app_algoriza/features/presentations/home/widgets/chart_widget.dart';
import 'package:weather_app_algoriza/features/presentations/home/widgets/next_six_days_widget.dart';
import 'package:weather_app_algoriza/features/presentations/home/widgets/side_bar_settings.dart';
import 'package:weather_app_algoriza/features/presentations/home/widgets/sunrise_and_sunset.dart';
import 'package:weather_app_algoriza/features/presentations/home/widgets/uv_wind_humidity.dart';
import '../../../../core/utils/network/remote/geolocator_service.dart';
import '../widgets/container_item.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get(context);
    SettingsCubit settingsCubit = SettingsCubit.get(context);

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is SuccessWeatherDataState) {
          SettingsCubit.get(context).addToRecentSearch(
              locationName: mainCubit.weatherDataModel!.location!.name!,
              temp: mainCubit.weatherDataModel!.current!.tempC!);

          if (settingsCubit.favoriteLocations.contains(
              mainCubit.weatherDataModel!.location!.name!.toLowerCase())) {
            mainCubit.isFavorite = true;
          } else {
            mainCubit.isFavorite = false;
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: mainCubit.weatherDataModel != null,
          builder: (context) {
            List<String> localDate =
                mainCubit.weatherDataModel!.location!.localTime!.split(" ");
            String currentDay =
                DateFormat('EEE').format(DateTime.parse(localDate[0]));
            String currentTime = localDate[1];
            // DateFormat("h:mma").format(date);
            // final time = TimeOfDay(hour: currentTime.trim(), minute: 12);
            // print(time.format(context));

            String weatherStatusImage = detectWeatherStatus(context);

            return Scaffold(
              key: drawerKey,
              drawer: SideBarSettings(),
              appBar: AppBar(
                // backgroundColor: Colors.red,
                toolbarHeight: 300,
                automaticallyImplyLeading: false,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            drawerKey.currentState!.openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu_outlined,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${mainCubit.weatherDataModel!.location!.name}",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white, fontSize: 30),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              mainCubit.makeFavorite();
                              addOrRemoveFromFavorites(
                                  context: context,
                                  locationName: MainCubit.get(context)
                                      .weatherDataModel!
                                      .location!
                                      .name!);
                            },
                            icon: mainCubit.isFavorite
                                ? const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  )
                                : const Icon(Icons.star_border_outlined)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${mainCubit.weatherDataModel!.current!.tempC!.floor()}\u00B0",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Feels like ${mainCubit.weatherDataModel!.current!.feelsLikeC!.floor()}\u00B0",
                                  style:
                                      Theme.of(context).textTheme.titleLarge!,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Image.asset(
                              weatherStatusImage,
                              height: 150,
                            ),
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.only(top: 20.0),
                          //   child: Icon(
                          //     Icons.sunny,
                          //     color: Colors.yellow,
                          //     size: 120,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 200,
                    toolbarHeight: 100,
                    // elevation: 10,
                    pinned: true,
                    stretch: true,

                    flexibleSpace: FlexibleSpaceBar(
                      // titlePadding: EdgeInsets.all(20),

                      // centerTitle: true,

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${mainCubit.weatherDataModel!.current!.condition!.text}",
                            style: Theme.of(context).textTheme.titleLarge!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            "${mainCubit.weatherDataModel!.forecastday[0].day!.minTempC!.floor()}\u00B0 / ${mainCubit.weatherDataModel!.forecastday[0].day!.maxTempC!.floor()}\u00B0",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "$currentDay $currentTime",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (state is LoadingState)
                            const Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: LinearProgressIndicator(
                                color: Colors.amberAccent,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            children: [
                              ChartWidget(
                                  weatherStatusPerHour: mainCubit
                                      .weatherDataModel!.forecastday[0].hour),
                              const SizedBox(
                                height: 20,
                              ),
                              DefaultContainer(
                                widgetItem: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Today's Temperature",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        "Expect the same as yesterday",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.grey[200]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              NextSixDays(
                                  forecastList:
                                      mainCubit.weatherDataModel!.forecastday),
                              const SizedBox(
                                height: 20,
                              ),
                              SunRiseAndSunset(),
                              const SizedBox(
                                height: 20,
                              ),
                              UvWindHumidity(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          fallback: (context) => Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to Weather App",
                      style: Theme.of(context).textTheme.headline5,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: Colors.grey[200],
                          )),
                          Text(
                            "  Or  ",
                            style: Theme.of(context).textTheme.titleMedium,
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
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (state is LoadingState)
                      const LinearProgressIndicator(
                        color: Colors.amberAccent,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String detectWeatherStatus(context) {
    MainCubit mainCubit = MainCubit.get(context);
    String image = '';
    if (mainCubit.weatherDataModel!.current!.condition!.text!
        .toLowerCase()
        .contains('sun')) {
      image = 'assets/icons/sunny.png';
    } else if (mainCubit.weatherDataModel!.current!.condition!.text!
        .toLowerCase()
        .contains('thunder')) {
      image = 'assets/icons/thunderstorm.png';
    } else if (mainCubit.weatherDataModel!.current!.condition!.text!
        .toLowerCase()
        .contains('rain')) {
      image = 'assets/icons/rainy.png';
    } else if (mainCubit.weatherDataModel!.current!.condition!.text!
        .toLowerCase()
        .contains('cloud')) {
      image = 'assets/icons/cloudy.png';
    } else if (mainCubit.weatherDataModel!.current!.condition!.text!
        .toLowerCase()
        .contains('wind')) {
      image = 'assets/icons/windy2.png';
    } else if (mainCubit.weatherDataModel!.current!.condition!.text!
        .toLowerCase()
        .contains('fog')) {
      image = 'assets/icons/foggy.png';
    } else if (mainCubit.weatherDataModel!.current!.condition!.text!
        .toLowerCase()
        .contains('snow')) {
      image = 'assets/icons/snow.png';
    } else {
      image = 'assets/icons/clear.png';
    }
    return image;
  }

  void addOrRemoveFromFavorites(
      {required context, required String locationName}) {
    if (SettingsCubit.get(context)
        .favoriteLocations
        .contains(locationName.toLowerCase())) {
      print("is already in list");
      SettingsCubit.get(context)
          .removeFromFavorites(locationName: locationName);
      // MainCubit.get(context).isFavorite = false;
    } else {
      SettingsCubit.get(context).addToFavorites(locationName: locationName);
      // MainCubit.get(context).isFavorite = true;
    }
    print(SettingsCubit.get(context).favoriteLocations);
  }
}
