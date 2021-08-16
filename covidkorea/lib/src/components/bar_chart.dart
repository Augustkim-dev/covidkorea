import 'package:covidkorea/src/model/covid_statistics_model.dart';
import 'package:covidkorea/src/utils.dart/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  final List<Covid19StatisticsModel> covidDatas;
  final double maxY;
  const CovidBarChart({Key? key, required this.covidDatas, required this.maxY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY * 1.5,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 8,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                rod.y.round().toString(),
                TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              return DataUtils.simpleDayFormat(
                  covidDatas[value.toInt()].stateDt!);
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: this.covidDatas.map<BarChartGroupData>((covidData) {
          return BarChartGroupData(
            x: x++,
            barRods: [
              BarChartRodData(
                  y: covidData.calcDecideCnt,
                  colors: [Colors.lightBlueAccent, Colors.greenAccent])
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
      ),
    );
  }
}
