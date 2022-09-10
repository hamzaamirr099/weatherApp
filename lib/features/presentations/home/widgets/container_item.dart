import 'package:flutter/material.dart';
import 'package:weather_app_algoriza/core/utils/main_bloc/main_cubit.dart';

import '../../../../core/shared/constants.dart';

class DefaultContainer extends StatelessWidget {
  final Widget widgetItem;
  DefaultContainer({Key? key, required this.widgetItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MainCubit.get(context).isDark ? darkModeWidgetColor :lightModeWidgetColor,
          border: MainCubit.get(context).isDark ? Border.all() : Border.all(color: Colors.white, width: 0.3),
          borderRadius: BorderRadius.circular(25)
      ),
      child: widgetItem,
    );
  }
}
