
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_algoriza/core/models/main_model.dart';
import '../../shared/functions.dart';
import '../network/remote/dio_helper.dart';
import '../network/remote/geolocator_service.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitState());

  static MainCubit get(context) => BlocProvider.of(context);

  TextEditingController countryNameController = TextEditingController();

  MainWeatherModel? weatherDataModel;

  Future<void> getWeatherData({required String countryName}) async {
    try {
      emit(LoadingState());
      Response value =
          await DioHelper.getData(url: '/v1/forecast.json', query: {
        'q': countryName,
        'days': 7,
        'key': '238c9ebf4e974919981161517220409',
      });
      weatherDataModel = MainWeatherModel.fromJson(value.data);

      emit(SuccessWeatherDataState());
      countryNameController.text = '';
    } on DioError catch (e) {
      if (e.response == null) {
        showToastMessage(message: "Check you connection");
      } else {
        print(e.response!.data);
        showToastMessage(message: "${e.response!.data['error']['message']}");
      }
      emit(FailedWeatherDataState());
    }
  }


  void getLonAndLat() async
  {
    emit(LoadingLonAndLatState());
    Position position =
        await GeolocatorService().determinePosition();
    print(position.latitude);
    print(position.longitude);
    getWeatherDataByLocation(
        longitude: position.longitude,
        latitude: position.latitude);
  }
  Future<void> getWeatherDataByLocation({required double longitude, required double latitude}) async {
    try {
      Response value =
      await DioHelper.getData(url: '/v1/forecast.json', query: {
        'q': "$latitude,$longitude",
        'days': 7,
        'key': '238c9ebf4e974919981161517220409',
      });
      weatherDataModel = MainWeatherModel.fromJson(value.data);

      emit(SuccessWeatherDataState());
    } on DioError catch (e) {
      if (e.response == null) {
        showToastMessage(message: "Check you connection");
      } else {
        print(e.response!.data);
        showToastMessage(message: "${e.response!.data['error']['message']}");
      }
      emit(FailedWeatherDataState());
    }
  }

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
    emit(ModeChangedState());
  }

  bool isFavorite = false;
  MainWeatherModel? myFavorite;

  void makeFavorite() {
    isFavorite = !isFavorite;
    emit(ChangeFavoriteState());
  }


}
