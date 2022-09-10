import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app_algoriza/core/models/hour_model.dart';

import 'container_item.dart';

class ChartWidget extends StatelessWidget {
  final List<Hour> weatherStatusPerHour;

  ChartWidget({Key? key, required this.weatherStatusPerHour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<WeatherAtThisHour> listToShow = [];
    // Map<String, int> mapToShow = {};
    for (var item in weatherStatusPerHour) {
      List<String> localDate = item.time!.split(" ");
      String time = localDate[1];
      int temp = item.tempC!.floor();
      listToShow.add(WeatherAtThisHour(time: time, temp: temp));
    }
    return DefaultContainer(
      widgetItem: Container(
        height: 250,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.purple,
                Colors.transparent,
                Colors.transparent,
                Colors.purple
              ],
              stops: [
                0.0,
                0.1,
                0.9,
                1.0
              ], // 10% purple, 80% transparent, 10% purple
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 35.0,
                    ),
                    child: SfCartesianChart(
                      title: ChartTitle(
                          text: "   Forecast along the day\n\n",
                          textStyle: const TextStyle(color: Colors.white),
                          alignment: ChartAlignment.near),
                      plotAreaBorderWidth: 0,
                      primaryXAxis: CategoryAxis(
                        //Hide the axis line of x-axis
                        axisLine: const AxisLine(width: 0),
                        maximumLabels: 100,
                        autoScrollingDelta: 5,
                        majorGridLines: const MajorGridLines(width: 0),
                        majorTickLines: const MajorTickLines(width: 0),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      primaryYAxis: CategoryAxis(
                          isVisible: false,
                          //Hide the gridlines of y-axis
                          majorGridLines: const MajorGridLines(width: 0),
                          //Hide the axis line of y-axis
                          axisLine: const AxisLine(width: 0)),
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                      ),
                      series: <ChartSeries>[
                        LineSeries<WeatherAtThisHour, String>(
                            color: Colors.white,
                            dataSource: listToShow,
                            xValueMapper: (WeatherAtThisHour model, _) =>
                                model.time,
                            yValueMapper: (WeatherAtThisHour model, _) =>
                                model.temp,
                            dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(color: Colors.white)),
                            markerSettings: const MarkerSettings(
                              isVisible: true,
                              width: 4,
                              height: 4,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherAtThisHour {
  String time;
  int temp;

  WeatherAtThisHour({required this.time, required this.temp});
}
