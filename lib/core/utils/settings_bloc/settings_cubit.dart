import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';
import 'package:weather_app_algoriza/core/utils/settings_bloc/settings_states.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(InitSettingsState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  List<String> recentSearchNames = [];
  List<double> recentSearchTemp = [];

  void addToRecentSearch({required String locationName, required double temp}) {
    if (recentSearchNames.length < 5 &&
        !recentSearchNames.contains(locationName)) {
      recentSearchNames.add(locationName);
      recentSearchTemp.add(temp);
    }
    emit(RecentSearchChangedState());
  }

  bool isManagedLocations = false;

  void manageLocations() {
    isManagedLocations = !isManagedLocations;
    emit(ManagedLocationState());
  }

  void deleteRecentItemAt({required int index})
  {
    recentSearchNames.removeAt(index);
    emit(RecentSearchItemRemoved());
  }

  List<String> favoriteLocations = [];
  void addToFavorites({required String locationName})
  {
    if(!favoriteLocations.contains(locationName.toLowerCase()))
      {
        favoriteLocations.add(locationName.toLowerCase());
      }
    emit(FavoritesLocationsChangedState());

  }

  void removeFromFavorites({required String locationName})
  {
    favoriteLocations.remove(locationName.toLowerCase());
    emit(FavoritesLocationsChangedState());
  }

}
