import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';
import 'package:weather_app_algoriza/core/utils/settings_bloc/settings_cubit.dart';
import 'package:weather_app_algoriza/core/utils/settings_bloc/settings_states.dart';
import 'package:weather_app_algoriza/core/widgets/default_text_field.dart';
import '../../../../core/shared/functions.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class SideBarSettings extends StatelessWidget {
  const SideBarSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get(context);
    SettingsCubit settingsCubit = SettingsCubit.get(context);
    settingsCubit.isManagedLocations = false;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: MediaQuery.of(context).size.height - 60,
        child: Drawer(
          backgroundColor: const Color(0xff2f3943),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.settings),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    controller: MainCubit.get(context).countryNameController,
                    hintText: "Search...",
                    onFieldSubmitted: (value) {
                      if (value!.isNotEmpty) {
                        mainCubit.getWeatherData(
                            countryName: mainCubit.countryNameController.text);

                        Navigator.pop(context);
                      } else {
                        showToastMessage(message: "Enter a city name");
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 40,),
                  mainCubit.isDark
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.light_mode),
                          const SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                                mainCubit.changeMode();
                              },
                              child: Text("Light mode", style: Theme.of(context).textTheme.titleMedium,)),
                        ],
                      )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.dark_mode_outlined),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            mainCubit.changeMode();
                          },
                          child: Text("Dark mode", style: Theme.of(context).textTheme.titleMedium,)),
                    ],
                  ),
                  mySeparator(),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Favorite locations",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  BlocConsumer<SettingsCubit, SettingsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return ConditionalBuilder(
                        condition: settingsCubit.favoriteLocations.isNotEmpty,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => favoriteLocation(context: context, locationName: settingsCubit.favoriteLocations[index]),
                          itemCount: settingsCubit.favoriteLocations.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        ),
                        fallback: (context) => Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "There is no favorite locations",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    },
                  ),
                  mySeparator(),
                  Row(
                    children: [
                      const Icon(Icons.history),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Recent locations",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  BlocConsumer<SettingsCubit, SettingsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => recentLocation(
                          context: context,
                          locationName: settingsCubit.recentSearchNames[index],
                          temp: settingsCubit.recentSearchTemp[index],
                          currentIndex: index,
                        ),
                        itemCount: settingsCubit.recentSearchNames.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      // mainCubit.recentSearchNames = [];
                      // mainCubit.recentSearchTemp = [];
                      settingsCubit.manageLocations();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff4f5762),
                      ),
                      child: Text(
                        "Manage locations",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  mySeparator(),
                  Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Report wrong location",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.call),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Contact us",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  mySeparator(),
                  InkWell(
                    onTap: () {
                      mainCubit.getLonAndLat();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff4f5762),
                      ),
                      child: Text(
                        "Get current location",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mySeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: List.generate(
          100,
          (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.white,
              height: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget favoriteLocation({required context, required String locationName}) {
    return InkWell(
      onTap: () {
        MainCubit.get(context).getWeatherData(
            countryName:locationName);
        // Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "${toBeginningOfSentenceCase(locationName)}",
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentLocation(
      {context,
      required String locationName,
      required double temp,
      required int currentIndex}) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: InkWell(
        onTap: (){
          MainCubit.get(context).getWeatherData(
              countryName:locationName);
        },

        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                locationName,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.brightness_1,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "${temp.floor()}\u00B0",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SettingsCubit.get(context).isManagedLocations
                ? Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: InkWell(
                      onTap: () {
                        SettingsCubit.get(context)
                            .deleteRecentItemAt(index: currentIndex);
                      },
                      child: const Icon(
                        Icons.delete_outlined,
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
