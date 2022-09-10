import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_states.dart';
import 'package:weather_app_algoriza/core/utils/network/remote/dio_helper.dart';
import 'package:weather_app_algoriza/core/utils/settings_bloc/settings_cubit.dart';
import 'package:weather_app_algoriza/features/presentations/home/screen/home_screen.dart';

import 'core/shared/constants.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (context) => MainCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor:lightModeBackGroundColor,
              appBarTheme: const AppBarTheme(elevation: 0.0, color: lightModeBackGroundColor),
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme:  const TextTheme(
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                headlineSmall: TextStyle(color: Colors.white),
                headlineMedium: TextStyle(color: Colors.white),
                headlineLarge: TextStyle(color: Colors.white),
              ),
              // primarySwatch: Colors.yellow,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor:darkModeBackGroundColor,
              appBarTheme: const AppBarTheme(elevation: 0.0, color: darkModeBackGroundColor),
              brightness: Brightness.dark,
            ),
            themeMode: MainCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
